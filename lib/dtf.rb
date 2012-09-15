# encoding: UTF-8

require "dtf/version"

module Dtf
  load "#{File.join(File.dirname(__FILE__), "/config/environment.rb")}"

  class Commands
    
    def process(cmd, cmd_opts)
      case cmd
        when "create_user"
          create_user(cmd_opts)

        when "delete_user"
          delete_user(cmd, cmd_opts)

        when "create_vs"
          create_vs(cmd_opts)

        when "delete_vs"
          delete_vs(cmd, cmd_opts)

        else
          $stderr.puts "Unknown DTF sub-command: #{cmd.inspect}"
          abort()
      end
    end
    
    def self.create_user(cmd_opts)
      if [:user_name_given, :full_name_given, :email_address_given].all? { |sym| cmd_opts.key?(sym) } then
        user = User.where(user_name:     cmd_opts[:user_name],
                           full_name:     cmd_opts[:full_name],
                           email_address: cmd_opts[:email_address]).first_or_create

        # Check to make sure user was actually saved to the db
        if user.persisted? then
          puts "Created user \'#{cmd_opts[:user_name]}\' for \'#{cmd_opts[:full_name]}\'"
        else
          # Oops, it wasn't! Notify user and display any error message(s)
          $stderr.puts "ERROR: #{cmd_opts[:user_name].to_s} was NOT created! Please fix the following errors and try again:"
          user.errors.messages.keys.each do |key|
            $stderr.puts "#{key.to_s.capitalize.gsub('_', ' ').to_s} #{user.errors.messages[key][0].to_s}!"
          end
          # Now throw a proper error code to the system, while exiting the script
          abort()
        end
      else
        raise_error # This error here is thrown when not all params are provided
      end
    end
    
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
        raise_error
      end
    end
    
    def self.create_vs(cmd_opts)
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
        raise_error
      end
    end
    
    def self.delete_vs(cmd, cmd_opts)
      if [:user_name_given, :id_given].all? { |sym| cmd_opts.key?(sym) } then
        puts "#{cmd} called! Deleting #{cmd_opts[:user_name]}\'s VS with ID \'#{cmd_opts[:id]}\'"
        user = User.find_by_user_name(cmd_opts[:user_name])
        vs   = user.verification_suites.find(cmd_opts[:id])
        VerificationSuite.delete(vs)
      else
        raise_error
      end
    end    

  end # End of class

end # End of module
