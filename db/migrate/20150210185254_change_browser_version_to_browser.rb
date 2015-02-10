class ChangeBrowserVersionToBrowser < ActiveRecord::Migration
  def change
    rename_column :fingerprints, :browser_version, :browser
  end
end
