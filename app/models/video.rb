# == Schema Information
#
# Table name: videos
#
#  id            :bigint           not null, primary key
#  name          :string           not null
#  recorded_at   :string
#  slug          :string           not null
#  status        :string           default("entered"), not null
#  transcription :jsonb
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  channel_id    :bigint
#  youtube_id    :string           not null
#
# Indexes
#
#  index_videos_on_channel_id  (channel_id)
#  index_videos_on_name        (name)
#  index_videos_on_status      (status)
#  index_videos_on_youtube_id  (youtube_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (channel_id => channels.id)
#
class Video < ApplicationRecord
    validates_presence_of :name, :slug, :status, :youtube_id
    belongs_to :channel


    enum status: {
        entered: 'entered',
        download_started: 'download_started',
        download_completed: 'download_completed',
        download_error: 'download_error',
        no_transcript: 'no_transcript',
        transcription_scraped: 'transcription_scraped'
    }

    def watch_url
        "https://www.youtube.com/watch?v=#{youtube_id}"
    end

    def embed_url
        "https://www.youtube.com/embed/#{youtube_id}"
    end
end
