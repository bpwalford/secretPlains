class ChangePluginAndFontType < ActiveRecord::Migration
  def change
    change_column :fingerprints, :plugins, :text
    change_column :fingerprints, :fonts, :text
  end
end
