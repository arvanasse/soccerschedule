class User < ActiveRecord::Base
  acts_as_authentic

  belongs_to :account

  has_many  :team_followers
  has_many  :teams, 
            :through => :team_followers

  validates_presence_of :account_id

  def following?( team_id )
    team_ids.include? team_id
  end
end
