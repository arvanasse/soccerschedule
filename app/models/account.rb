class Account < ActiveRecord::Base
  validates_presence_of :name

  has_many :advertisements
  has_many :users
  has_many :teams
  has_many :classifications
end
