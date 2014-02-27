class AddWeatherLocationsToSite < ActiveRecord::Migration
  def change
    add_column :sites, :weather_location_id, :int
  end
end
