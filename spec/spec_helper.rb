require 'dtf'
require 'rspec'
require 'turnip'
require 'fabrication'

# Require any RSpec support files, helpers, and custom matchers we define
Dir[File.join(File.dirname(__FILE__), "support/**/*.rb")].each do |f|
  require f
end

# Turnip steps load line
Dir.glob("spec/steps/**/*steps.rb") do |f|
  load f, true
end

RSpec.configure { |c| c.include ModelSteps }
