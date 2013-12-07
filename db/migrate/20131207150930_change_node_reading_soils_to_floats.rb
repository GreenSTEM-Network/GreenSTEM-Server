class ChangeNodeReadingSoilsToFloats < ActiveRecord::Migration
  def up
    change_column :node_readings, :soil1, :decimal
    change_column :node_readings, :soil2, :decimal
    change_column :node_readings, :soil3, :decimal
  end

  def down
  end
end
