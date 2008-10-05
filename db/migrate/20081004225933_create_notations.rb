class CreateNotations < ActiveRecord::Migration
  def self.up
    create_table :notations do |t|
      t.string :title
      t.text :body
      t.integer :note_id
      t.string :note_type
      t.timestamps
    end
  end

  def self.down
    drop_table :notations
  end
end
