# -*- coding: UTF-8 -*-

class User < ActiveRecord::Base

  attr_accessible :full_name, :email_address, :user_name
  validates_presence_of :full_name, :email_address, :user_name

  has_many :verification_suites, :dependent => :destroy
  has_many :analysis_cases, :through => :verification_suites, :dependent => :destroy
  has_many :case_tests, :through => :verification_suites, :dependent => :destroy

end
