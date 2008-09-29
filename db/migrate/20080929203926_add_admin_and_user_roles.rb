class AddAdminAndUserRoles < ActiveRecord::Migration
  def self.up
    admin = Role.create(
      :title => 'admin',
      :description => 'Administrator role'
    )
    Role.create(
      :title => 'user',
      :description => 'Basic user role'
    )
    root = User.find_by_login 'root'
    root && root.roles << admin
  end

  def self.down
    ['admin', 'user'].each do |role|
      r = Role.find_by_title role
      r && r.destroy
    end
  end
end
