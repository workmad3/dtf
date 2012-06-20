class AnalysisCase < ActiveRecord::Base

  attr_accessible :name, :description
  validates_presence_of :name, :description

  belongs_to  :verification_suite
  has_many    :users, :through => :verification_suite
  has_many :case_tests

end
