# == Schema Information
#
# Table name: announcements
#
#  id         :integer          not null, primary key
#  body       :text
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  dig_id     :integer          not null
#  poster_id  :integer          not null
#
# Indexes
#
#  index_announcements_on_dig_id     (dig_id)
#  index_announcements_on_poster_id  (poster_id)
#
# Foreign Keys
#
#  dig_id     (dig_id => digs.id)
#  poster_id  (poster_id => posters.id)
#
class Announcement < ApplicationRecord
  belongs_to :poster
  belongs_to :dig
end
