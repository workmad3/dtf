# Reusable error response method
def raise_error
  raise ArgumentError
rescue
  $stderr.puts "ERROR! #{@cmd} did not receive all required options."
  $stderr.puts "See 'dtf #{@cmd} -h' for help with this sub-command"

  # Set non-zero exit value on error, for scripting use.
  abort()
end

def display_errors()
  # TODO: Refactor error display to take sub-command as an arg
  # and display obj.errors.messages.each properly for each arg type.
end
