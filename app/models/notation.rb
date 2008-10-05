class Notation < ActiveRecord::Base
  belongs_to :note, :polymorphic => true
  has_many :notes, :as => :note, :class_name => 'Notation'
end
