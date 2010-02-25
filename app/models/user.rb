class User < ActiveRecord::Base
  acts_as_authentic

  has_many  :team_followers
  has_many  :teams, 
            :through => :team_followers

  def following?( team_id )
    team_ids.include? team_id
  end
end
