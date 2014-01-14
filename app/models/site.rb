class Site < ActiveRecord::Base
  attr_accessible :node_ids, :nodes_attributes, :address, :description, :name, :zipcode

  has_many :nodes

  has_many :readings, :through => :nodes, :source => 'readings'
  accepts_nested_attributes_for :readings, :allow_destroy => true

end
