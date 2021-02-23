class IntroduceUniqueConstraintsOnChannelsAndVideos < ActiveRecord::Migration[6.1]
  def change
    add_index :channels, :url, unique: true
    add_index :videos, :youtube_id, unique: true
  end
end
