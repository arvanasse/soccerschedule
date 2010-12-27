class ScheduleLink < ActiveRecord::Base
  belongs_to :team

  validates_presence_of :team_id, :url, :expires_on

  scope :active, :conditions => ["expires_on >= ?", Date.today]
end
