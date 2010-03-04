class CreateClassifications < ActiveRecord::Migration
  def self.up
    create_table :classifications do |t|
      t.string :name

      t.timestamps
    end

    change_table :teams do |t|
      t.references :classification
    end
  end

  def self.down
    remove_column :teams, :classification_id
    drop_table :classifications
  end
end
