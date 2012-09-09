step "I have dtf installed" do
  if Dtf::VERSION.empty?    
    puts "Dtf gem not loaded"
    exit 1      
  end
end

# $cmd is any one of the various current dtf cmd management / control structures
# TODO: Rewrite to use a single dtf control script, and modular cmd|subcmd exec|help systems
step "I request help on all available sub commands:" do |table|
  @cmds = {}
  
  table.hashes.each do |hash|
    @cmds[hash['cmd']] = hash['cmd_output']
  end
  # puts "@cmds is a #{@cmds.class.to_s}"
  # puts "@cmds keys are: #{@cmds.keys}"
  # puts "@cmds values are: #{@cmds.values}"
end

step "I should receive each command's specific details" do
  # Display actual help for specific $cmd space
  @cmds.each do |cmd|
    result = %x[bundle exec dtf #{cmd[0]} -h]
    result.should include("#{cmd[1].to_s}")
  end
end