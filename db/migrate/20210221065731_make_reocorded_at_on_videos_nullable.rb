class MakeReocordedAtOnVideosNullable < ActiveRecord::Migration[6.1]
  def change
    change_column_null :videos, :recorded_at, true
  end
end
