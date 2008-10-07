class Software < ActiveRecord::Base
  has_many :comments, :as => :commentable, :dependent => :destroy 
  
  validates_size_of :title, :within => 1..255
  validates_uniqueness_of :title
end
