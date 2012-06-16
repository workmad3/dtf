class CaseTest < ActiveRecord::Base

  attr_accessible :description, :cmd
  validates_presense_of :description, :cmd

  has_many    :users, :through => :verification_suite
  has_one     :verification_suite, :through => :analysis_case
  belongs_to  :analysis_case

end
