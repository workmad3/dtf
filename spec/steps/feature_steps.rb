step "I have dtf installed" do
  if Dtf::VERSION.empty?
    fail("DTF gem not loaded")
  end
end

# $cmd is any one of the various current dtf cmd management / control structures
# TODO: Rewrite to use a single dtf control script, and modular cmd|subcmd exec|help systems
step "I request help for sub-command :sub_cmd" do |cmd|
  @cmds = {}
  @cmds[cmd] = ''
end

step "I should see :help_response in the response" do |help_response|
  # Display actual help for specific $cmd space
  @cmds.each do |cmd|
    cmd[1] = "#{help_response}"
    result = %x[bundle exec dtf #{cmd[0]} -h]
    result.should include("#{cmd[1]}")
  end
end