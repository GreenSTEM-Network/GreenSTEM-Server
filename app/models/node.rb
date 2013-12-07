class Node < ActiveRecord::Base
  attr_accessible :channel, :project_type, :voltage
  belongs_to :site
  has_many :node_readings
end
