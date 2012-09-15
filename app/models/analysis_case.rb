# encoding: UTF-8

class AnalysisCase < ActiveRecord::Base

  attr_accessible :name, :description
  validates_presence_of :name, :description

  belongs_to  :verification_suite, :autosave => :true
  belongs_to  :user, :autosave => :true
  has_many :case_tests, :dependent => :destroy

end
