class Comment < ActiveRecord::Base
  belongs_to :commentable, :polymorphic => true
  belongs_to :user
  
  has_many :comments, :as => :commentable, :dependent => :destroy
  def top_commentable
    object = self.commentable;
    object = object.commentable while object.is_a?(Comment);
    object
  end
  
  def to_liquid
    {'parent_object' => top_commentable }
  end
  
  validates_presence_of :body
  
  acts_as_textile :body
  
  def before_create
    self.user_id = (User.current_user && User.current_user.id)
  end
  
  def full_control_by_current_user?
    User.current_user == self.user || User.current_user.role_check('admin')
  end
end
