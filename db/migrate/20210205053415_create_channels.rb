class CreateChannels < ActiveRecord::Migration[6.1]
  def change
    create_table :channels do |t|
      t.string :name, null: false, index: true
      t.string :slug, null: false
      t.string :logo_url, null: false
      t.string :channel_type, null: false, index: true

      t.timestamps
    end
  end
end