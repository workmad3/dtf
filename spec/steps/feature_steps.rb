step "I have dtf installed" do
  if Dtf::VERSION.empty?    
    puts "Dtf gem not loaded"
    exit 1      
  end
end

# $cmd is any one of the various current dtf cmd management / control structures
# TODO: Rewrite to use a single dtf control script, and modular cmd|subcmd exec|help systems
step "I type :cmd" do |cmd|
  # Change this to check programmatically that $cmd implements --help param
  @cmd_text = %x[bin/#{cmd}]
end

step "I should see help system output" do
  # Display actual help for specific $cmd space
  @cmd_text.should include("help")
end
