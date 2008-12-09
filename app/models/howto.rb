class Howto < ActiveRecord::Base
  has_many :comments, :as => :commentable, :dependent => :destroy
  belongs_to :user
  
  def before_create
    self.user_id = (User.current_user && User.current_user.id)
  end
end
