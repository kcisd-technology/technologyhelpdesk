class Software < ActiveRecord::Base
  validates_size_of :title, :within => 1..255
  validates_uniqueness_of :title
end
