class CreateRootUser < ActiveRecord::Migration
  def self.up
    User.create(:login=> 'root', 
      :email=> 'root@example.com',
      :password=> 'blah', 
      :password_confirmation=> 'blah')
  end

  def self.down
    root = User.find_by_login('root')
    root && root.destroy
  end
end
