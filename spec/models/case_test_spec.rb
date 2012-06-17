require 'spec_helper'

describe "Case Test" do

  it "should be created/fabricated" do
    ct = Fabricate(:case_test)
    ct.should be_a(CaseTest)
  end
end
