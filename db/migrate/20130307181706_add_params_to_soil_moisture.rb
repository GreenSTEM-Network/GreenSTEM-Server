class AddParamsToSoilMoisture < ActiveRecord::Migration
  def change
      change_table :soilmoistures do |t|
          t.references :collection_point
          t.datetime :collection_time
      end
  end
end
