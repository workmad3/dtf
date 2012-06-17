require 'spec_helper'

describe "Verification Suite" do

  it "should be created/fabricated" do
    vs = Fabricate(:verification_suite)
    vs.should be_a(VerificationSuite)
  end
end
