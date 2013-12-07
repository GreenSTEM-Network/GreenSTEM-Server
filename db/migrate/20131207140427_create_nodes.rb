class CreateNodes < ActiveRecord::Migration
  def change
    create_table :nodes do |t|
      t.integer :channel
      t.string :project_type
      t.integer :voltage
      t.references :site

      t.timestamps
    end
    add_index :nodes, :site_id
  end
end
