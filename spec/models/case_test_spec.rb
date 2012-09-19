# encoding: UTF-8

require 'spec_helper'

describe "CaseTest" do

  context "when instantiated" do

    let(:case_test) { CaseTest.new }
    
    it "should be the proper class" do
      case_test.should be_a(CaseTest)      
    end
    
    it "should be invalid without being assigned to a analysis case" do
      case_test.should_not be_valid
      case_test.errors.should_not be_empty
      case_test[:analysis_case_id].should be_nil
      case_test.new_record?.should be_true
    end  
  
    it "should be invalid without a cmd" do    
      case_test.should_not be_valid
      case_test.errors.should_not be_empty
      case_test.errors.messages[:cmd].should eq(["can't be blank"])
      case_test.new_record?.should be_true
    end
    
    it "should be invalid without a description" do    
      case_test.should_not be_valid
      case_test.errors.should_not be_empty
      case_test.errors.messages[:description].should eq(["can't be blank"])
      case_test.new_record?.should be_true
    end

    it "should not be saved" do
      case_test.new_record?.should be_true
      case_test.persisted?.should_not be_true
    end

  end  
  
  context "when created" do
    user = Fabricate(:user)
    vs = user.verification_suites.create(name: "RSpec Test VS", description: "Bogus VS for RSpec")
    analysis_case = vs.analysis_cases.create(name: "RSpec Test AC", description: "Bogus AC for RSpec")
    case_test = analysis_case.case_tests.create(cmd: "bundle exec rspec spec", 
                                                description: "Bogus CT for RSpec"
                                                )
    
    it "should be owned by an analysis case" do    
      case_test.should be_valid
      case_test.analysis_case_id.should_not be_nil
    end  

    it "should have a valid cmd and description" do    
      case_test.should be_valid
      case_test.errors.should be_empty
      case_test.cmd.should_not be_nil
      case_test.description.should_not be_nil
    end  
  
    it "should be saved" do
      case_test.should be_valid
      case_test.new_record?.should_not be_true
      case_test.persisted?.should be_true
    end
  end
end
