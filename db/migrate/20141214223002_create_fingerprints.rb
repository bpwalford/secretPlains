class CreateFingerprints < ActiveRecord::Migration
  def change
    create_table :fingerprints do |t|
      t.belongs_to :user
      t.string :plugins
      t.string :fonts
      t.string :user_agent
      t.string :browser_version
      t.string :cookies
      t.string :language

      t.timestamps
    end
  end
end
