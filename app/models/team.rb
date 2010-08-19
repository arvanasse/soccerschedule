class Team < ActiveRecord::Base
  belongs_to :classification
  belongs_to :account

  has_many  :schedule_links

  has_many  :team_followers
  has_many  :users,
            :through => :team_followers

  validates_presence_of :account_id, :classification, :name

  state_machine :initial => :visible do
    state :visible
    state :hidden

    event :hide do 
      transition :visible => :hidden
    end

    event :show do
      transition :hidden => :visible
    end
  end

  def urls
    schedule_links.active.map(&:url)
  end
end
