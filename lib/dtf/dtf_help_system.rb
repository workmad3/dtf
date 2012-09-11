# DTF Help System
require 'trollop' # Used to implement help system

SUB_COMMANDS = %w(create_user delete_user create_vs delete_vs)

# Global options default to '--version|-v' and '--help|-h'
global_opts = Trollop::options do
  version "DTF v#{Dtf::VERSION}"
  banner <<-EOS
  #{version}
  (c) Copyright 2012 David Deryl Downey / Deryl R. Doucette. All Rights Reserved.
  This is free software; see the LICENSE file for copying conditions.
  There is NO warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
  
  Usage:
        dtf -v|--version -h|--help [[sub_cmds <options>] -h|--help]
  
  Valid [sub_cmds] are: create_(user|vs), delete_(user|vs)
  See 'dtf [sub_cmd] -h' for each sub_cmd's details and options
    
EOS
  stop_on SUB_COMMANDS
end

# Sub-commands go here
@cmd = ARGV.shift
@cmd_opts = case @cmd
  when "create_user"
    Trollop::options do
      opt(:user, desc="Username for new TF user - REQUIRED", opts={:type => :string, :short => '-u'})
      opt(:name, desc="Real name for new TF user - REQUIRED", opts={:type => :string, :short => '-n'})
      opt(:email, desc="Email address for new TF user - REQUIRED", opts={:type => :string, :short => '-e'})
    end
  when "create_vs"
    Trollop::options do
      opt(:user, desc="TF user to associate this VS with - REQUIRED", opts={:type => :string, :short => '-u'})
      opt(:name, desc="Descriptive name for new VS - REQUIRED", opts={:type => :string, :short => '-n'})      
    end
  when "delete_user"
    Trollop::options do
      opt(:user, desc="Username of TF user to delete - REQUIRED", opts={:type => :string, :short => '-u'})
      opt(:delete_all, desc="Delete _all_ VSs this user owns", :type => :flag, :default => true)
    end
  when "delete_vs"
    Trollop::options do
      opt(:user, desc="Username of VS owner - REQUIRED", opts={:type => :string, :short => '-u'})
      opt(:id, desc="ID of VS to be deleted - REQUIRED", opts={:type => :int, :short => '-i'})
    end
  when nil
    Trollop::die "No command specified! Please specify an applicable command"
  else
    Trollop::die "Unknown DTF sub-command: #{cmd.inspect}"
  end
