class DropIps < ActiveRecord::Migration
  def change
    drop_table :ips
  end
end
