# == Schema Information
#
# Table name: dig_images
#
#  id          :integer          not null, primary key
#  cover_photo :boolean          default(FALSE)
#  image_url   :string
#  notes       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  dig_id      :integer          not null
#  user_id     :integer          not null
#
# Indexes
#
#  index_dig_images_on_dig_id   (dig_id)
#  index_dig_images_on_user_id  (user_id)
#
# Foreign Keys
#
#  dig_id   (dig_id => digs.id)
#  user_id  (user_id => users.id)
#
class DigImage < ApplicationRecord
  mount_uploader :image_url, ImageUrlUploader
  belongs_to :dig
  belongs_to :user
end
