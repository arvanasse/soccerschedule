class AddAccountOwnership < ActiveRecord::Migration
  def self.up
    add_column :teams, :account_id, :integer
    add_column :users, :account_id, :integer
    add_column :classifications, :account_id, :integer
  end

  def self.down
    remove_column :teams, :account_id
    remove_column :users, :account_id
    remove_column :classifications, :account_id
  end
end
