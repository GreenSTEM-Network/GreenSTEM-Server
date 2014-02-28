class AddIsDisabledToNode < ActiveRecord::Migration
  def change
  	add_column :nodes, :is_disabled, :boolean
  end
end
