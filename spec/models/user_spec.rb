require 'spec_helper'

describe "User" do

  it "should create a user" do
    user = Fabricate(:user)
    user.should be_a(User)
  end
end
