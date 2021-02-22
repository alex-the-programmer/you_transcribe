class CreateTopics < ActiveRecord::Migration[6.1]
  def change
    create_table :topics do |t|
      t.string :name, null: false
      t.string :status, null: false, default: :entered, index: true

      t.timestamps
    end

    add_column :channels, :topic_id, :integer
    add_foreign_key :channels, :topics
  end
end
