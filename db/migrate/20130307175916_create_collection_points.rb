class CreateCollectionPoints < ActiveRecord::Migration
  def change
    create_table :collection_points do |t|
        t.text :name
        t.references :site
        t.timestamps
    end
  end
end
