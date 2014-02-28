class CreateSoilTypes < ActiveRecord::Migration
  def change
    create_table :soil_types do |t|
      t.string :name
      t.text :description
      t.decimal :moist_threshold
      t.decimal :wilting_threshold

      t.timestamps
    end
  end
end
