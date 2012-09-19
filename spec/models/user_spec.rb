# encoding: UTF-8

require 'spec_helper'

describe "User" do

  context "when instantiated" do

    let(:user) { User.new }
    
    it "should be the proper class" do
      user.should be_a(User)      
    end

    it "should be invalid without a user_name" do    
      user.should_not be_valid
      user.errors.should_not be_empty
      user.errors.messages[:user_name].should eq(["can't be blank"])
      user.new_record?.should be_true
    end  
  
    it "should be invalid without an email_address" do    
      user.should_not be_valid
      user.errors.should_not be_empty
      user.errors.messages[:email_address].should eq(["can't be blank"])
      user.new_record?.should be_true
    end
    
    it "should be invalid without a full_name" do    
      user.should_not be_valid
      user.errors.should_not be_empty
      user.errors.messages[:full_name].should eq(["can't be blank"])
      user.new_record?.should be_true
    end

    it "should not be saved" do
      user.new_record?.should be_true
      user.persisted?.should_not be_true
    end

  end  
  
  context "when created" do
    let(:user) { Fabricate(:user)}
    
    it "should have a valid user_name, full_name, and email_address" do    
      user.should be_valid
      user.errors.should be_empty
      user.user_name.should_not be_nil
      user.full_name.should_not be_nil
      user.email_address.should_not be_nil
    end  
  
    it "should be saved" do
      user.new_record?.should_not be_true
      user.persisted?.should be_true
    end
  end
end
