# Reusable error response method
def raise_error
  raise ArgumentError
  rescue
    puts "ERROR! #{@cmd} did not receive all required options."
    puts "See 'dtf #{@cmd} -h' for help with this sub-command"

    # Set non-zero exit value on error, for scripting use.
    exit 255
end
