class SoilType < ActiveRecord::Base
  attr_accessible :name, :description, :moist_threshold, :wilting_threshold

  has_many :sites

  def to_s
    name
  end

  accepts_nested_attributes_for :sites, :allow_destroy => true
end
