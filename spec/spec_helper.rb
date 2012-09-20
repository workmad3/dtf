# encoding: UTF-8
require 'cover_me'
require 'dtf'
require 'rspec'
require 'turnip'
require 'fabrication'
require 'database_cleaner'

# Require any RSpec support files, helpers, and custom matchers we define
Dir[File.join(File.dirname(__FILE__), "support/**/*.rb")].each do |f|
  require f
end

# Turnip steps load line
Dir.glob("spec/steps/**/*steps.rb") do |f|
  load f, true
end

# This links RSpec and Turnip for the models
RSpec.configure { |c| c.include ModelSteps }

# This config section is for DatabaseCleaner
RSpec.configure do |config|

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

end
