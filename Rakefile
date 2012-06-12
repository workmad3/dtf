#!/usr/bin/env rake
require "bundler/gem_tasks"

begin
    require 'tasks/standalone_migrations'
rescue LoadError => e
    puts "gem install standalone_migrations to get db:migrate:* tasks! (Error: #{e})"
end

