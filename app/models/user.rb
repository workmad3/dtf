# encoding: UTF-8

class User < ActiveRecord::Base

  attr_accessible :full_name, :email_address, :user_name
  validates :full_name, :email_address, :user_name, :presence => true
  validates :user_name, :email_address, :uniqueness => true

  has_many :verification_suites, :dependent => :destroy
  has_many :analysis_cases, :through => :verification_suites, :dependent => :destroy
  has_many :case_tests, :through => :verification_suites, :dependent => :destroy

end
