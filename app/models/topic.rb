# == Schema Information
#
# Table name: topics
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  status     :string           default("entered"), not null
#  topic_type :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_topics_on_status  (status)
#
class Topic < ApplicationRecord
    validates_presence_of :name, :status

    has_many :channels

    enum status: {
        entered: 'entered',
        processed: 'processed'
    }
end
