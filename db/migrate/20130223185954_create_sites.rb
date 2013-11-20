class CreateSites < ActiveRecord::Migration
  def change
    create_table :sites do |t|
      t.string :name
      t.text :description
      t.string :address
      t.string :zipcode

      t.timestamps
    end
  end
end
