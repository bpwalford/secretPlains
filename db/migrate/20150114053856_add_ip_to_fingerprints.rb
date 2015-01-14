class AddIpToFingerprints < ActiveRecord::Migration
  def change
    add_column :fingerprints, :ip, :string
    add_column :fingerprints, :screen, :string
    add_column :fingerprints, :country, :string
  end
end
