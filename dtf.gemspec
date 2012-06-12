# -*- encoding: utf-8 -*-
require File.expand_path('../lib/dtf/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors           = ["Deryl R. Doucette"]
  gem.email             = ["me@deryldoucette.com"]
  gem.description       = %q{DTF is a modular testing framework skeleton. This is the control gem which contains the Suite's db schema(s) and control/management scripts.}
  gem.summary           = %q{DTF is a modular testing framework. This is the control gem.}
  gem.homepage          = "https://github.com/dtf-gems/dtf"

  gem.platform          = Gem::Platform::RUBY
  gem.files             = `git ls-files`.split($\)
  gem.executables       = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files        = gem.files.grep(%r{^(test|spec|features)/})
  gem.name              = "dtf"
  gem.require_paths     = ["lib"]
  gem.version           = Dtf::VERSION
  gem.rubyforge_project = "dtf"
  gem.required_ruby_version = ">= 1.9.3"

  gem.add_dependency "rake"
  gem.add_dependency "sqlite3"

  gem.add_development_dependency "standalone-migrations"
  gem.add_development_dependency "rspec"
  gem.add_development_dependency "turnip"

end
