class Site < ActiveRecord::Base
  attr_accessible :node_ids, :nodes_attributes, :address, :description, :name, :zipcode, :weather_location_id, :soil_type_id

  has_many :nodes
  has_many :node_readings, through: :nodes, source: :readings

  belongs_to :weather_location

  belongs_to :soil_type

  # accepts_nested_attributes_for :readings, :allow_destroy => true

end
