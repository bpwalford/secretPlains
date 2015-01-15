class ChangeDifferenceFontsToDecimal < ActiveRecord::Migration
  def change
    change_column :differences, :fonts, :decimal, precision: 3
  end
end
