class RenameUrlToIdOnVideos < ActiveRecord::Migration[6.1]
  def change
    rename_column :videos, :url, :youtube_id
  end
end
