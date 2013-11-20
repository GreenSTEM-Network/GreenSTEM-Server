class MakeDataCollectionMoreGeneral < ActiveRecord::Migration
  def up
      change_table :data_collections do |t|
          t.remove :collected_date, :soil_moisture_low, :soil_moisture_medium, :soil_moisture_high, :temperature, :sunlight, :waterlevel, :site_id
      end
  end

  def down
  end
end
