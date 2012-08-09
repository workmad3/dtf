# -*- coding: UTF-8 -*-

require 'spec_helper'
require 'benchmark'

describe "User" do

  puts "User Benchmark"
  puts Benchmark.measure { let (:user) { Fabricate(:user) } }

  let (:user) { Fabricate(:user) }

  it "should be created/fabricated" do
    user.should be_a(User)
  end

  it "should be persisted" do
    user.save
    user.persisted?
  end
end
