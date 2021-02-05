class CreateVideos < ActiveRecord::Migration[6.1]
  def change
    create_table :videos do |t|
      t.belongs_to :channel
      t.string :name, null: false, index: true
      t.string :slug, null: false
      t.string :transcription
      t.string :recorded_at, null: false
      t.string :status, null: false, default: :entered, index: true

      t.timestamps
    end
  end
end
