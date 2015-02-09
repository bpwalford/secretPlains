class ChangeLevToDistance < ActiveRecord::Migration
  def change
    rename_column :differences, :plugins_lev, :plugins_distance
    rename_column :differences, :user_agent_lev, :user_agent_distance
    rename_column :differences, :browser_lev, :browser_distance
  end
end
