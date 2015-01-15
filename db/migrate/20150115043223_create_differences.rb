class CreateDifferences < ActiveRecord::Migration
  def change
    create_table :differences do |t|
      t.belongs_to 'user'
      t.belongs_to 'fingerprint'

      t.integer    'plugins'
      t.integer    'fonts'
      t.integer    'user_agent'

      t.boolean    'browser_version'
      t.boolean    'cookies'
      t.boolean    'language'
      t.boolean    'ip'
      t.boolean    'screen'
      t.boolean    'country'

      t.timestamps
    end
  end
end
