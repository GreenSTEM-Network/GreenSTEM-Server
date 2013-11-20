class AddSiteIdToDataCollection < ActiveRecord::Migration
  def change
    add_column :data_collections, :site_id, :int
  end
end
