# -*- coding: UTF-8 -*-

module ModelSteps

  step "a user" do
    @user = Fabricate(:user)
    @user.should_not be_nil
  end

  step "a verification suite" do
    @vs = Fabricate(:verification_suite)
    @vs.should_not be_nil
  end

  step "I should see an analysis case" do
    @ac = Fabricate(:analysis_case)
    @ac.should_not be_nil
  end

  step "I should see a case test" do
    @ct = Fabricate(:case_test)
    @ct.should_not be_nil
  end

  step "I should see user ownership chain via :association" do |association|
    @user.send(association).build
    @user.send(association).should_not be_nil
  end

  step "I create a/an :association" do |association|
    @user.send(association.pluralize).build
  end

  step "I should see my :association" do |association|
    @user.send(association.pluralize).should_not be_empty
  end

end

placeholder :association do
  match /(\w+(?: \w+)*)/ do |assoc_name|
    assoc_name.gsub(' ', '_')
  end
end


