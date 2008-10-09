class Comment < ActiveRecord::Base
  belongs_to :commentable, :polymorphic => true
  belongs_to :user
  
  has_many :comments, :as => :commentable, :dependent => :destroy
  
  validates_size_of :title, :within => 1..255
  validates_presence_of :body
  
  acts_as_textile :body
  #acts_as_markup :language => :redcloth, :columns => [:body]
  
  def before_create
    self.user_id = (User.current_user && User.current_user.id)
  end
  
  def full_control_by_current_user?
    User.current_user == self.user || User.current_user.role_check('admin')
  end
end
