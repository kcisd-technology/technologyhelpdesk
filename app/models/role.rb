class Role < ActiveRecord::Base
  has_and_belongs_to_many :users
  
  validates_uniqueness_of :title
  validates_size_of :title, :within => 1..255
end
