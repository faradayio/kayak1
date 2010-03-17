class DropSearches < ActiveRecord::Migration
  def self.up
    drop_table :searches
  end

  def self.down
    create_table :searches do |t|
      t.string :origin_airport
      t.string :destination_airport
      t.timestamps
    end
  end
end
