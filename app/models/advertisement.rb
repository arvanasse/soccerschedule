class Advertisement < ActiveRecord::Base
  has_attached_file :logo, :path => ":rails_root/public/images/logo/:id/:style/:filename",
                           :url  => "/images/logo/:id/:style/:filename"
  belongs_to :account

  validates_presence_of :account_id, :company, :url
end
