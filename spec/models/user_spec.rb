require 'spec_helper'

describe "User" do

  let(:user) { Fabricate(:user) }

  it "should be created/fabricated" do
    user.should be_a(User)
  end

  it "should be persisted" do
    user.save
    user.persisted?
  end
end
