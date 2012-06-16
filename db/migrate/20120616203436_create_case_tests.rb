class CreateCaseTests < ActiveRecord::Migration
  def self.up
    create-table :case_tests do |t|
      t.string      :description
      t.text        :cmd
      t.references  :analysis_case

      t.timestamps
    end
  end

  def self.down
    drop_table :case_tests
  end
end
