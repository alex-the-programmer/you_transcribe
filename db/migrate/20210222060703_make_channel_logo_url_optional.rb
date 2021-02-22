class MakeChannelLogoUrlOptional < ActiveRecord::Migration[6.1]
  def change
    change_column_null :channels, :logo_url, true
  end
end
