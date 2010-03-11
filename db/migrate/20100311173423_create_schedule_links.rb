class CreateScheduleLinks < ActiveRecord::Migration
  def self.up
    create_table :schedule_links do |t|
      t.references :team
      t.string :url
      t.date :expires_on

      t.timestamps
    end

    expiration = Date.new 2010, 4, 30
    Team.all.each{|team| team.schedule_links.create :url => team.url, :expires_on => expiration }

    remove_column :teams, :url
  end

  def self.down
    drop_table :schedule_links
  end
end
