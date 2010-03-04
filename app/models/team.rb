class Team < ActiveRecord::Base
  belongs_to :classification
  has_many  :team_followers

  has_many  :users,
            :through => :team_followers
end
