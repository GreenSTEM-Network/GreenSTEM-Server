class CreateSoilmoistures < ActiveRecord::Migration
  def change
    create_table :soilmoistures do |t|
      t.float :deptha
      t.float :depthb
      t.float :depthc

      t.timestamps
    end
  end
end
