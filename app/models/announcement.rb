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
#  poster_id  (poster_id => users.id)
#
class Announcement < ApplicationRecord
  belongs_to :poster, class_name: "User", foreign_key: "poster_id"
  belongs_to :dig

  validates :title, presence: true
end
