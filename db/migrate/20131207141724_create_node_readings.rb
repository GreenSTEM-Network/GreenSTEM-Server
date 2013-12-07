class CreateNodeReadings < ActiveRecord::Migration
  def change
    create_table :node_readings do |t|
      t.datetime :collection_time
      t.references :node
      t.integer :soil1
      t.integer :soil2
      t.integer :soil3
      t.integer :temp

      t.timestamps
    end
    add_index :node_readings, :node_id
  end
end
