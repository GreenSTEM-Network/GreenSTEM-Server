class AddTimeToDataCollection < ActiveRecord::Migration
  def change
      change_table :data_collections do |t|
          t.datetime :collection_time
      end
  end
end
