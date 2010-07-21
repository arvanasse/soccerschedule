class TeamFollower < ActiveRecord::Base
  belongs_to :team
  belongs_to :user

  validates_presence_of :team_id, :user_id
end
