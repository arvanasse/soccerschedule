class Classification < ActiveRecord::Base
  belongs_to  :account
  has_many    :teams, :order => :name

  validates_presence_of :account_id, :name
end
