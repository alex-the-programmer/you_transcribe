# == Schema Information
#
# Table name: channels
#
#  id           :bigint           not null, primary key
#  channel_type :string           not null
#  logo_url     :string
#  name         :string           not null
#  slug         :string           not null
#  url          :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  topic_id     :integer
#
# Indexes
#
#  index_channels_on_channel_type  (channel_type)
#  index_channels_on_name          (name)
#  index_channels_on_url           (url) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (topic_id => topics.id)
#
class Channel  < ApplicationRecord
    validates_presence_of :channel_type, :name, :slug

    has_many :videos, dependent: :destroy
    belongs_to :topic
end
