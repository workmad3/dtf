# encoding: UTF-8

require "dtf/version"

module Dtf
  load "#{File.join(File.dirname(__FILE__), "/config/environment.rb")}"

  # Dtf::Command contains all sub-commands availabe in the DTF master gem.
  # All methods recieve the @cmd and @cmd_opts parsed from the command-line.
  # They are what was captured in the ivars in Dtf::HelpSystem
  class Command
    require "dtf/error_system"

    # Process both the requested command and all/any parameters.
    # NOTE: This method is the 'master' method. It parses @cmd for which sub-command to execute and then hands
    # off to the appropriate method. All methods are a 1:1 match in their name.
    # e.g 'create_user' sub-command is matched to the 'create_user' method of this class.
    #
    # This method requires, and processes, 2 arguments. The 'cmd' to process, and any 'cmd_opts' of that sub-command.
    def self.process(cmd, cmd_opts)
      case cmd
        when "create_user"
          create_user(cmd, cmd_opts)

        when "delete_user"
          delete_user(cmd, cmd_opts)

        when "create_vs"
          create_vs(cmd, cmd_opts)

        when "delete_vs"
          delete_vs(cmd, cmd_opts)

        else
          $stderr.puts "Unknown DTF sub-command: #{cmd}"
          abort()
      end
    end

    # This sub-command is used to add a User to the Test Framework system
    #
    # Required Parameters are:
    #  --user-name [String], --full-name [String], --email-address [String]
    #
    # '--user-name' is used to specify the user_name of the created User, and *must* be unique in the system.
    # '--full-name' is the Real Name of the created User.
    # '--email-address' is the email address of the created User, and *must* be unique in the system.
    def self.create_user(cmd, cmd_opts)
      if [:user_name_given, :full_name_given, :email_address_given].all? { |sym| cmd_opts.key?(sym) } then
        user = User.where(user_name:     cmd_opts[:user_name],
                           full_name:     cmd_opts[:full_name],
                           email_address: cmd_opts[:email_address]).create

        # Check to make sure user was actually saved to the db
        if user.persisted? then
          puts "Created user \'#{cmd_opts[:user_name]}\' for \'#{cmd_opts[:full_name]}\'"
        else
          # Oops, it wasn't! Notify user and display any error message(s)
          $stderr.puts "ERROR: #{cmd_opts[:user_name].to_s} was NOT created! Please fix the following errors and try again:"
          user.errors.full_messages.each do |msg|
            $stderr.puts "#{msg}"
          end
          # Now throw a proper error code to the system, while exiting the script
          abort()
        end
      else
        raise_error(cmd) # This error here is thrown when not all params are provided
      end
    end

    # This sub-command removes a User from the Testing Framework system
    #
    # Required Parameters are:
    #  --user-name [String]
    #
    # '--user-name' is the assigned user_name of the User you wish to delete.
    #
    # Optional Flags are:
    #  --delete-all|--no-delete-all
    #
    # By default this command will delete *all* Verification Suites owned by the deleted user.
    # The default behaviour is as if the sub-command had been invoked passing the '--delete-all' flag explicitly.
    #
    # To delete the user, but *keep* their VS, pass the '--no-delete-all' flag.
    # This flag will find all Verification Suites owned by the user being deleted, and reassign them
    # to 'Library Owner' (user_name: library_owner) which is the generic in-house User shipped with DTF.
    def self.delete_user(cmd, cmd_opts)
      if [:user_name_given, :delete_all].all? { |sym| cmd_opts.key?(sym) } then
        # NOTE: :delete_all is 'true' by default. passing '--no-delete-all' sets it to false,
        # and adds the :delete_all_given key to the cmd_opts hash, set to true.
        # This means NOT to delete all VSs associated with this user. We delete them by default.
        if cmd_opts[:delete_all] == false && cmd_opts[:delete_all_given] == true
          puts "#{cmd} called with '--no-delete-all' set! NOT deleting all owned VSs!"
          puts "Reassigning VSs to Library. New owner will be \'Library Owner\'"
          user      = User.find_by_user_name(cmd_opts[:user_name])
          lib_owner = User.find_by_user_name("library_owner")
          user.verification_suites.all.each do |vs|
            vs.user_id = lib_owner.id
            vs.save
          end
          User.delete(user)
        else
          puts "#{cmd} called with '--delete-all' set or on by default! Deleting all VSs owned by #{cmd_opts[:user_name]}"
          user = User.find_by_user_name(cmd_opts[:user_name])
          user.verification_suites.all.each do |vs|
            VerificationSuite.delete(vs)
          end
          if user.verification_suites.empty? then
            User.delete(user)
          end
        end
      else
        raise_error(cmd)
      end
    end

    # This sub-command generates, adds, and associates a Verification Suite in the Testing Framework system.
    #
    # Required Parameters are:
    #  --user-name [String], --name [String]
    #
    # '--user-name' is the user_name of the User that should own this Verification Suite.
    # '--name' is the descriptive name of the Verification Suite.
    #
    # Options are:
    #  --description [String]
    #
    # This *optional* parameter is for providing a description of the Verification Suite's use.
    # e.g. --description "RSpec Verification"
    #
    def self.create_vs(cmd, cmd_opts)
      if [:user_name_given, :name_given].all? { |sym| cmd_opts.key?(sym) } then
        user = User.find_by_user_name(cmd_opts[:user_name])
        vs   = user.verification_suites.create(name: cmd_opts[:name], description: cmd_opts[:description])
        if vs.persisted? then
          puts "VS named \'#{cmd_opts[:name]}\' allocated to user \'#{cmd_opts[:user_name]}\'"
        else
          $stderr.puts "ERROR: Failed to save Verification Suite. Check DB logfile for errors"
          abort()
        end
      else
        raise_error(cmd)
      end
    end

    # This sub-command removes a Verification Suite from the Testing Framework system
    #
    # Required Parameters are:
    #  --user-name [String], --id [Integer]
    #
    # The '--user-name' parameter is the user_name of the User that owns the Verification Suite you wish to delete
    # The '--id' parameter is the ID # of the Verification Suite you wish to delete, as provided by @vs.id
    def self.delete_vs(cmd, cmd_opts)
      if [:user_name_given, :id_given].all? { |sym| cmd_opts.key?(sym) } then
        puts "#{cmd} called! Deleting #{cmd_opts[:user_name]}\'s VS with ID \'#{cmd_opts[:id]}\'"
        user = User.find_by_user_name(cmd_opts[:user_name])
        vs   = user.verification_suites.find(cmd_opts[:id])
        VerificationSuite.delete(vs)
      else
        raise_error(cmd)
      end
    end

  end # End of class

end # End of module
