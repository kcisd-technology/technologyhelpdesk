class Device < ActiveRecord::Base
  has_many :comments, :as => :commentable, :dependent => :destroy 
end
