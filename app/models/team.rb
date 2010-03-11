class Team < ActiveRecord::Base
  belongs_to :classification
  has_many  :schedule_links

  has_many  :team_followers
  has_many  :users,
            :through => :team_followers

  def urls
    schedule_links.active.map(&:url)
  end
end
