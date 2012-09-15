# encoding: UTF-8

module ModelSteps

  step "a User" do
    @user = Fabricate(:user)
    @user.should be_a(User)
    @user.should_not be_nil
  end

  step "a Verification Suite" do
    @vs = Fabricate(:verification_suite)
    @vs.should be_a(VerificationSuite)
    @vs.should_not be_nil
  end

  step "I create a/an :association" do |association|
    @user.send(association.downcase.pluralize).build
  end

  step "I should own a/an :association" do |association|
    @user.send(association.downcase.pluralize).should_not be_empty
  end

  step "I should see an Analysis Case" do
    @ac = Fabricate(:analysis_case)
    @ac.should be_a(AnalysisCase)
    @ac.should_not be_nil
  end

  step "I should see a Case Test" do
    @ct = Fabricate(:case_test)
    @ct.should be_a(CaseTest)
    @ct.should_not be_nil
  end

end

placeholder :association do
  match /(\w+(?: \w+)*)/ do |assoc_name|
    assoc_name.gsub(' ', '_')
  end
end


