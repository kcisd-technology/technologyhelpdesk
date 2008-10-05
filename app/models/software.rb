class Software < ActiveRecord::Base
  has_many :notes, :as => :note, :class_name => 'Notation'
  
  validates_size_of :title, :within => 1..255
  validates_uniqueness_of :title
end
