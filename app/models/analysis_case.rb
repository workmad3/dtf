class AnalysisCase < ActiveRecord::Base

  attr_accessible :name, :description
  validates_presense_of :name, :description

  has_many    :users, :through => :verification_suite
  belongs_to  :verification_suite
  has_many :case_tests

end
