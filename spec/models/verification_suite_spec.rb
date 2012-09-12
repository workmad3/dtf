# -*- coding: UTF-8 -*-

require 'spec_helper'

describe "Verification Suite" do

  let(:verification_suite) { Fabricate(:verification_suite) }

  it "should be created/fabricated" do
    verification_suite.should be_a(VerificationSuite)
  end

  it "should be persisted" do
    verification_suite.save
    verification_suite.persisted?
  end
end
