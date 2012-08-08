
0.2.2 / 2012-08-08 
==================

  * Fixed up included baseline pry and related gems. Now using pry-debugger which uses debugger gem.
  * Forgot to add doc/.gitkeep so that git retains the (currently) empty directory
  * Removed doc directory from .gitignore since we plan on storing docs here
  * Added /db/config.yml and /db/*.sqlite3 to .gitignore file
  * We run thor dtf_setup:config so no need to put the config there ahead of time.
  * Defaulted the gem to RAILS_ENV='production'. Modified .travis.yml to set this to 'development' before running commands. This affects ActiveRecord database selection, and whether testing gems are available.
  * Updated associations to include dependent destroy and autosave
  * Added entry to TODO to remember to change ENV['RAILS_ENV'] to production upon gem release. Also put TODO note in environment.rb [ci skip]
  * Added config.ymla nd dtf-setup
  * Added dtf-setup script to do setup
  * Forgot to add require 'thor' for tasks
  * Forgot to remove pry-coolline from environment.rb as well. sigh
  * Forgot to commit Gemfile without pry-coolline. It breaks a lot of core functionality features in pry which uses readline instead, so tab completion and the like are busted.
  * Added bundle exec gem list to before_script for travis. Travis doesn't output a list of gems used, and since this is itself a gem there is no Gemfile.lock committed. So this is the only way to see what versions of dependencies are being installed since the version isn't locked down within the gemspec.
  * Incorrect numbering of tests. Really just these 2 files should be numbered because they should run before all other tests. The reasoning is that by testing basic model creation, and basic core associations first then all other tests should succeed so run them first.
  * Added additional steps definitions and feature for testing basic model associations
  * Removed auto-fabrication of a verification suite for fabricated analysis cases as that will cause problems in testing.
  * Updated migrations to reflect changeout of HABTM for has_many :through. Deleted HABTM join table migration.
  * Changed out HABTM association from models for belongs_to and has_many :through
  * Just adding dep for pry-theme so I can use different color coding. No code changes. [ci skip]
  * Fixed the matcher thanks to workmad3 explaining what I was doing wrong. Bad matcher.
  * Split out to :association as workmad3 was indicating. But for some reason its not finding the step anymore. Getting 'No such step' on user ownership tracking through verification_suites.
  * Broke CI testing because pry is not being loaded. Forgot to add :test group to Gemfile
  * bin directory should have contents +755.
  * Added RVM version check to .rvmrc file. Moved Pry development dependencies to Gemfile from gemspec because gemspec does not support using :git with dependencies. Gemfile does.
  * For some reason git marked bin/.gitkeep chmod 755. NO, bad git
  * Added a dependency on vcr gem. dtf will contain the core of the connection API which each sub-module gem extends for its portion. In order to be able to replay with exactness, I decided to try out 'vcr'.
  * Last bit of ordering on case_test
  * Reordering associations
  * Fix association ordering in models
  * Added notes for going forward to TODO list. [ci skip]
  * Modified rspec model tests to ensure Models are properly created, and persisted.
  * Added RSpec steps for '0001_create_basic_models.feature' using fabrication of each of the base models
  * Added core models and ownership directions test, as a turnip feature
  * Fixed .travis.yml config. Forgot to add thor dtf_setup:config for copying db/config.yml
  * Added travis-ci.org .travis.yml configuration file for public CI testing
  * Fixed fabricators as they had bad var names and logic. Fixed and added specs for each model. Tests and Fabricators PASS
  * Added RSpec and Turnip infrastructure, and a basic User spec
  * Added lib/config/environment.rb for environmental control. Updated .gitignore to remove config dir
  * Added fabrication gem to gemspec. Created Fabricators for each model
  * Added logic to lib/dtf/rb to load the model files so that require 'dtf' autoloaded them
  * Renamed incorrectly named AnalysisSuite to AnalysisCase and renamed associated migration. Fixed typo in AnalysisCase and CaseTest validations. Added additional deps for pry to dtf.gemspec for development mode. Added corrected db/schema.rb
  * Fixed formatting of schema.rb
  * Fixed typos in migrations and added db/schema.rb to repo
  * Mode change on dtf-create_vs script
  * Updated dependencies for Active(Record|Model|Support) and json(_pure) to gemspec
  * Added models and migrations for User, Verification Suite, Analysis Case, and Case Test with associations migration
  * Added basic outline of dtf-* management scripts
  * Added bin directory as this is where the control/management scripts will live.
  * Added db/.gitkeep and db/migrate/.gitkeep to ensure directory structure stays even if empty
  * Renamed database.yml to config.yml for standalone_migrations. renamed examples/config to examples/db to coincide with destination dir names
  * db/migrations is deprecated for d/migrate so changed the dirname and related thor tasks
  * Added example sqlite3 dtf_*.sqlite3 database.yml file. This gets copied by thor dtf_setup:config
  * Added directory logic to the thor install and config options because the copy operatins are copying files relative to the gem to places relative to the user's project, so the paths have to change.
  * Changed thor task class to DtfSetup to isolate namespace
  * Added db/migrations directory and updated setup.thor with install and config tasks
  * Updated .gitignore to ignore config/ and added examples directory with config subdir for thor setup:install task
  * Added thor setup task
  * Incorrect rspec version currently
  * Updated gemspec to rely on rspec 2.10.1 or higher, and am changing to using thor for task management
  * Added .idea and pmip to gitignore
  * Added a TODO file for tracking forward movement
  * Added .idea and pmip directories to .gitignore file.
  * Needlessly added dependency. Calling gem 'rspec' pulls in rspec-core, rspec-expectations, and rspec-mocks so no need to explicitly declare rspec-expectations
  * Added standalone_migrations tasks call to Rakefile
  * Added rspec and turnip infrastructure directories
  * Added .rspec file to connect turnip
  * Development dependency reordering
  * Added pry and related gems, plus rspec-expectations, and standalone_migrations development dependencies
  * Extended description of gem to better define gem contents and function
  * Initial commit of DTF's dtf infrastructure gem
