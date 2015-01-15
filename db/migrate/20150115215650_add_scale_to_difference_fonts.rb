class AddScaleToDifferenceFonts < ActiveRecord::Migration
  def change
    change_column :differences, :fonts, :decimal, precision: 3, scale: 2
  end
end
