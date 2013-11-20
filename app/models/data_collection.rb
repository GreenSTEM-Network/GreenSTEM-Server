class DataCollection < ActiveRecord::Base
  attr_accessible :site_id, :collected_date, :soil_moisture_high, :soil_moisture_low, :soil_moisture_medium, :sunlight, :temperature, :waterlevel

  belongs_to :collection_point
end
