class CreateAnalysisSuites < ActiveRecord::Migration
  def self.up
    create_table :analysis_suites do |t|
      t.string      :name
      t.string      :description
      t.references  :verification_suite

      t.timestamps
    end
  end

  def self.down
    drop_table :analysis_suites
  end
end
