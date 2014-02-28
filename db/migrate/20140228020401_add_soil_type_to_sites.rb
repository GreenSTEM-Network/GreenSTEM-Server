class AddSoilTypeToSites < ActiveRecord::Migration
  def change
    add_column :sites, :soil_type_id, :int
  end
end
