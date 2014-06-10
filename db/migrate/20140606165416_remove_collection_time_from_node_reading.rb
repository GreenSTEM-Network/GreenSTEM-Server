class RemoveCollectionTimeFromNodeReading < ActiveRecord::Migration
  def change
  	remove_column :node_readings, :collection_time
  end
end
