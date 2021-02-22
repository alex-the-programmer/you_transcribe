class AddTopicTypeToTopics < ActiveRecord::Migration[6.1]
  def change
    add_column :topics, :topic_type, :string
  end
end
