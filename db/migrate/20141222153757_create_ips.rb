class CreateIps < ActiveRecord::Migration
  def change
    create_table :ips do |t|
      t.string :ip
      t.string :city
      t.string :region_code
      t.string :region_name
      t.string :metrocode
      t.string :zipcode
      t.string :latitude
      t.string :longitude
      t.string :country_name
      t.string :country_code
      t.belongs_to :user

      t.timestamps
    end
  end
end
