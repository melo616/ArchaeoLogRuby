# == Schema Information
#
# Table name: images
#
#  id             :integer          not null, primary key
#  cover_photo    :boolean          default(FALSE)
#  image_url      :string
#  imageable_type :string           not null
#  notes          :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  imageable_id   :integer          not null
#  poster_id      :integer          not null
#
# Indexes
#
#  index_images_on_imageable  (imageable_type,imageable_id)
#  index_images_on_poster_id  (poster_id)
#
# Foreign Keys
#
#  poster_id  (poster_id => users.id)
#
class Image < ApplicationRecord
  belongs_to :imageable, polymorphic: true
  belongs_to :poster, class_name: "User", foreign_key: "poster_id"

  #for image uploads
  mount_uploader :image_url, ImageUrlUploader
end
