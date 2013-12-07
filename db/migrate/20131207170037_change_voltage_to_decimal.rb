class ChangeVoltageToDecimal < ActiveRecord::Migration
  def up
    change_column :nodes, :voltage, :decimal
  end

  def down
  end
end
