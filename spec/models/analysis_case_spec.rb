require 'spec_helper'

describe "Analysis Case" do

  puts "Analysis Case Benchmark"
  puts Benchmark.measure { let (:analysis_case) { Fabricate(:analysis_case) } }


  let(:analysis_case) { Fabricate(:analysis_case) }

  it "should be created/fabricated" do
    analysis_case.should be_a(AnalysisCase)
  end

  it "should be persisted" do
    analysis_case.save
    analysis_case.persisted?
  end
end
