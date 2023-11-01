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
#  dig_id_id   :integer          not null
#  user_id_id  :integer          not null
#
# Indexes
#
#  index_dig_images_on_dig_id_id   (dig_id_id)
#  index_dig_images_on_user_id_id  (user_id_id)
#
# Foreign Keys
#
#  dig_id_id   (dig_id_id => dig_ids.id)
#  user_id_id  (user_id_id => user_ids.id)
#
class DigImage < ApplicationRecord
  belongs_to :dig
end
