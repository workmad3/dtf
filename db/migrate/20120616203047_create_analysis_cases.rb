class CreateAnalysisCases < ActiveRecord::Migration
  def self.up
    create_table :analysis_cases do |t|
      t.string      :name
      t.string      :description
      t.references  :verification_suite

      t.timestamps
    end
  end

  def self.down
    drop_table :analysis_cases
  end
end
