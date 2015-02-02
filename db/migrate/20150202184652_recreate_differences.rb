class RecreateDifferences < ActiveRecord::Migration
  def change
    create_table :differences do |t|
      t.belongs_to :original
      t.belongs_to :altered

      t.text    'plugins_intersection'
      t.integer 'plugins_lev'
      t.text    'user_agent_intersection'
      t.integer 'user_agent_lev'
      t.text    'browser_intersection'
      t.integer 'browser_lev'

      t.text    'fonts_intersection'
      t.decimal 'percent_font_match', precision: 3, scale: 2

      t.boolean 'cookies'
      t.boolean 'language'
      t.boolean 'ip'
      t.boolean 'screen'
      t.boolean 'country'

      t.timestamps
    end
  end
end
