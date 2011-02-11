class CreateUserAgents < ActiveRecord::Migration
  def self.up
    create_table :user_agents do |t|
      t.string :name
      t.integer :count, :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :user_agents
  end
end
