class AddLoginNameToPerson < ActiveRecord::Migration
  def self.up
    add_column :people, :login_name, :string
  end

  def self.down
    remove_column :people, :login_name
  end
end
