class Node < ActiveRecord::Base
  attr_accessible :channel, :project_type, :voltage
  belongs_to :site
  has_many :readings, class_name: "NodeReading"
end
