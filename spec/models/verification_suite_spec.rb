require 'spec_helper'
require 'benchmark'

describe "Verification Suite" do

  puts "Verification Suite Benchmark"
  puts Benchmark.measure { let (:verification_suite) { Fabricate(:verification_suite) } }
  
  let(:verification_suite) { Fabricate(:verification_suite) }

  it "should be created/fabricated" do
    verification_suite.should be_a(VerificationSuite)
  end

  it "should be persisted" do
    verification_suite.save
    verification_suite.persisted?
  end
end
