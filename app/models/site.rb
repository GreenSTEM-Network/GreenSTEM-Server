class Site < ActiveRecord::Base
  attr_accessible :address, :description, :name, :zipcode

  has_many :nodes
  has_many :node_readings, :through => :nodes

end
