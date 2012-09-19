# encoding: UTF-8

require 'spec_helper'

describe "VerificationSuite" do

  context "when instantiated" do

    let(:verification_suite) { VerificationSuite.new }
    
    it "should be the proper class" do
      verification_suite.should be_a(VerificationSuite)      
    end
    
    it "should be invalid without being assigned to a user" do
      verification_suite.should_not be_valid
      verification_suite.errors.should_not be_empty
      verification_suite[:user_id].should be_nil
      verification_suite.new_record?.should be_true
    end  
  
    it "should be invalid without a name" do    
      verification_suite.should_not be_valid
      verification_suite.errors.should_not be_empty
      verification_suite.errors.messages[:name].should eq(["can't be blank"])
      verification_suite.new_record?.should be_true
    end
    
    it "should be invalid without a description" do    
      verification_suite.should_not be_valid
      verification_suite.errors.should_not be_empty
      verification_suite.errors.messages[:description].should eq(["can't be blank"])
      verification_suite.new_record?.should be_true
    end

    it "should not be saved" do
      verification_suite.new_record?.should be_true
      verification_suite.persisted?.should_not be_true
    end

  end  
  
  context "when created" do
    user = Fabricate(:user)
    verification_suite = user.verification_suites.create(name: "RSpec Test VS", description: "Bogus VS for RSpec")
      
    it "should be owned by a user" do
      verification_suite.user_id.should_not be_nil
    end  

    it "should have a valid name and description" do    
      verification_suite.should be_valid
      verification_suite.errors.should be_empty
      verification_suite.name.should_not be_nil
      verification_suite.description.should_not be_nil      
    end  
  
    it "should be saved" do
      verification_suite.should be_valid
      verification_suite.new_record?.should_not be_true
      verification_suite.persisted?.should be_true
    end
  end
end
