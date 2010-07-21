class CreateAdvertisements < ActiveRecord::Migration
  def self.up
    create_table :advertisements do |t|
      t.references :account
      t.string :name
      t.string :description
      t.string :state
      t.string :url

      t.string :logo_file_type
      t.string :logo_content_type
      t.integer :logo_size

      t.timestamps
    end
  end

  def self.down
    drop_table :advertisements
  end
end
