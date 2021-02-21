class ChangeTranscriptionToJsonB < ActiveRecord::Migration[6.1]
  def change
    remove_column :videos, :transcription, :string
    add_column :videos, :transcription, :jsonb
  end
end
