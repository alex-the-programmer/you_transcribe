# == Schema Information
#
# Table name: videos
#
#  id            :integer          not null, primary key
#  name          :string           not null
#  recorded_at   :string           not null
#  slug          :string           not null
#  status        :string           default("entered"), not null
#  transcription :string
#  url           :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  channel_id    :integer
#
# Indexes
#
#  index_videos_on_channel_id  (channel_id)
#  index_videos_on_name        (name)
#  index_videos_on_status      (status)
#
# Foreign Keys
#
#  channel_id  (channel_id => channels.id)
#
class Video < ApplicationRecord
    validate_presence_of :name, :recorded_at, :slug, :status, :url
    belongs_to :channel


    enum :status, {
        entered: 'entered'
    }

    before_save do 
        slug = name.parametrize
    end
end
