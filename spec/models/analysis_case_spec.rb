require 'spec_helper'

describe "Analysis Case" do

  it "should be created/fabricated" do
    ac = Fabricate(:analysis_case)
    ac.should be_a(AnalysisCase)
  end
end
