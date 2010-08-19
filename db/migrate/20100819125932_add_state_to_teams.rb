class AddStateToTeams < ActiveRecord::Migration
  def self.up
    add_column :teams, :state, :string
    Team.update_all "state = 'visible'"
  end

  def self.down
    remove_column :teams, :state
  end
end
