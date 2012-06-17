require 'spec_helper'

describe "User" do

  it "should be created/fabricated" do
    user = Fabricate(:user)
    user.should be_a(User)
  end
end
