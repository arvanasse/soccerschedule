class Classification < ActiveRecord::Base
  belongs_to  :account
  has_many    :teams

  validates_presence_of :account_id, :name
end
