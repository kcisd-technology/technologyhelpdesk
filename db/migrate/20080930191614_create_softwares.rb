class CreateSoftwares < ActiveRecord::Migration
  def self.up
    create_table :softwares do |t|
      t.string :title
      t.integer :copies
      t.timestamps
    end
  end

  def self.down
    drop_table :softwares
  end
end
