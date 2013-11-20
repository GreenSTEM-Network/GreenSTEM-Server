class Soilmoisture < ActiveRecord::Base
  attr_accessible :deptha, :depthb, :depthc, :collection_point_id, :collection_time

  belongs_to :collection_point

end
