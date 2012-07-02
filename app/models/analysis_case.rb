class AnalysisCase < ActiveRecord::Base

  attr_accessible :name, :description
  validates_presence_of :name, :description

  belongs_to  :verification_suite
  belongs_to  :user
  has_many :case_tests

end
