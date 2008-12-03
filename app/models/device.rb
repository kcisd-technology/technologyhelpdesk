class Device < ActiveRecord::Base
  has_many :comments, :as => :commentable, :dependent => :destroy
  liquid_methods :serial, :hostname, :ip_address, :description, :mac_address
end
