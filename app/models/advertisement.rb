class Advertisement < ActiveRecord::Base
  has_attached_file :logo, :path => ":rails_root/public/images/logo/:id/:style/:filename",
                           :url  => "/images/logo/:id/:style/:filename"
  belongs_to :account

  validates_presence_of :account_id, :company, :url

  named_scope :active, :conditions => { :state => 'active' }

  state_machine :initial => :pending do
    state :pending
    state :active
    state :inactive

    event :activate do
      transition all => :active
    end

    event :suspend do
      transition :active => :inactive
    end
  end

  class << self
    def random_selection
      offset = rand( active.count )
      active.scoped( :offset => offset, :limit => 1).first
    end
  end
end
