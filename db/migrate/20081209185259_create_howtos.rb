class CreateHowtos < ActiveRecord::Migration
  def self.up
    create_table :howtos do |t|
      t.string :title
      t.text :body
      t.belongs_to :user
      t.timestamps
    end
  end

  def self.down
    drop_table :howtos
  end
end
