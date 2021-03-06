class CreateVerificationSuites < ActiveRecord::Migration
  def self.up
    create_table :verification_suites do |t|
      t.string      :name
      t.text        :description
      t.references  :user
      t.timestamps
    end
  end

  def self.down
    drop_table :verification_suites
  end
end
