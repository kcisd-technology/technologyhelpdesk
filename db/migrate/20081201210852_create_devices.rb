class CreateDevices < ActiveRecord::Migration
  def self.up
    create_table :devices do |t|
      t.string :serial
      t.text :description
      t.string :hostname
      t.string :ip_address
      t.string :mac_address

      t.timestamps
    end
  end

  def self.down
    drop_table :devices
  end
end
