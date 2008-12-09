class Howto < ActiveRecord::Base
  belongs_to :commentable, :polymorphic => true
  belongs_to :user
  
  def before_create
    self.user_id = (User.current_user && User.current_user.id)
  end
end
