class ScheduleLink < ActiveRecord::Base
  belongs_to :team

  named_scope :active, :conditions => ["expires_on >= ?", Date.today]
end
