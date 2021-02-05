# == Schema Information
#
# Table name: channels
#
#  id           :integer          not null, primary key
#  channel_type :string           not null
#  logo_url     :string           not null
#  name         :string           not null
#  slug         :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_channels_on_channel_type  (channel_type)
#  index_channels_on_name          (name)
#
class Channel  < ApplicationRecord
    validate_presence_of :channel_type, :logo_url, :name, :slug

    has_many :videos

    before_save do 
        slug = name.parametrize
    end
end
