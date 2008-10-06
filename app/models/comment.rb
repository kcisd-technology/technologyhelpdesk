class Comment < ActiveRecord::Base
  belongs_to :commentable, :polymorphic => true
  belongs_to :user
  
  has_many :comments, :as => :commentable
  
  validates_size_of :title, :within => 1..255
  
  def before_create
    self.user_id = (User.current_user && User.current_user.id)
  end
end
