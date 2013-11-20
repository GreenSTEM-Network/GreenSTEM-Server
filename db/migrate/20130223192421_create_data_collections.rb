class CreateDataCollections < ActiveRecord::Migration
  def change
    create_table :data_collections do |t|
      t.datetime :collected_date
      t.decimal :soil_moisture_low
      t.decimal :soil_moisture_medium
      t.decimal :soil_moisture_high
      t.decimal :temperature
      t.decimal :sunlight
      t.decimal :waterlevel

      t.timestamps
    end
  end
end
