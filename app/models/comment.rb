class Comment < ActiveRecord::Base
  belongs_to :commentable, :polymorphic => true
  belongs_to :user
  
  has_many :comments, :as => :commentable
  
  def before_create
    self.user_id = User.current_user
  end
end
