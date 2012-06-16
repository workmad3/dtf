class UsersVerificationSuites < ActiveRecord::Migration
  def self.up
    create_table :users_verification_suites, :id => false do |t|
    t.references :user
    t.references :verification_suite
    end
  end

  def self.down
    drop_table :users_verification_suites
  end
end
