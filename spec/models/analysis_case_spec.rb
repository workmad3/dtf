# encoding: UTF-8

require 'spec_helper'

describe "AnalysisCase" do

  context "when instantiated" do

    let(:analysis_case) { AnalysisCase.new }
    
    it "should be the proper class" do
      analysis_case.should be_a(AnalysisCase)      
    end
    
    it "should be invalid without being assigned to a verification suite" do    
      analysis_case.should_not be_valid
      analysis_case.errors.should_not be_empty
      analysis_case[:verification_suite_id].should be_nil
      analysis_case.new_record?.should be_true
    end  
  
    it "should be invalid without a name" do    
      analysis_case.should_not be_valid
      analysis_case.errors.should_not be_empty
      analysis_case.errors.messages[:name].should eq(["can't be blank"])
      analysis_case.new_record?.should be_true
    end
    
    it "should be invalid without a description" do    
      analysis_case.should_not be_valid
      analysis_case.errors.should_not be_empty
      analysis_case.errors.messages[:description].should eq(["can't be blank"])
      analysis_case.new_record?.should be_true
    end

    it "should not be saved" do
      analysis_case.new_record?.should be_true
      analysis_case.persisted?.should_not be_true
    end

  end  
  
  context "when created" do
    user = Fabricate(:user)
    vs = user.verification_suites.create(name: "RSpec Test VS", description: "Bogus VS for RSpec")
    analysis_case = vs.analysis_cases.create(name: "RSpec Test AC", description: "Bogus AC for RSpec")
      
    it "should be owned by a verification suite" do    
      analysis_case.should be_valid
      analysis_case.verification_suite_id.should_not be_nil
    end  

    it "should have a valid name and description" do    
      analysis_case.should be_valid
      analysis_case.errors.should be_empty
      analysis_case.name.should_not be_nil
      analysis_case.description.should_not be_nil
    end  
  
    it "should be saved" do
      analysis_case.should be_valid
      analysis_case.new_record?.should_not be_true
      analysis_case.persisted?.should be_true
    end
  end
end
