class CreateTeamFollowers < ActiveRecord::Migration
  def self.up
    create_table :team_followers do |t|
      t.references :team
      t.references :user

      t.timestamps
    end
  end

  def self.down
    drop_table :team_followers
  end
end
