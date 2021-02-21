class AddUrlToChannels < ActiveRecord::Migration[6.1]
  def change
    add_column :channels, :url, :string
  end
end
