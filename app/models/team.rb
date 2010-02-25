class Team < ActiveRecord::Base
  has_many  :team_followers

  has_many  :users,
            :through => :team_followers
end
