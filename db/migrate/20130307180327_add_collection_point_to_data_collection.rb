class AddCollectionPointToDataCollection < ActiveRecord::Migration
  def change
      change_table :data_collections do |t|
          t.references :collection_point
      end
  end
end
