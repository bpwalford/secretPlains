class DropDifferences < ActiveRecord::Migration
  def change
    drop_table :differences
  end
end
