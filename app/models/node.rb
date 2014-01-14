class Node < ActiveRecord::Base
  attr_accessible :reading_ids, :readings_attributes, :site_id, :channel, :project_type, :voltage

  belongs_to :site

  has_many :readings, class_name: "NodeReading"
  accepts_nested_attributes_for :readings, :allow_destroy => true
end
