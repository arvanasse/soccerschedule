class AddReminderToUser < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.boolean :reminders
    end
  end

  def self.down
    remove_column :users, :reminders
  end
end
