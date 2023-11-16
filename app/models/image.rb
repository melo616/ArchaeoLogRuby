# == Schema Information
#
# Table name: images
#
#  id             :integer          not null, primary key
#  cover_photo    :boolean          default(FALSE)
#  image_url      :string
#  imageable_type :string
#  notes          :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  imageable_id   :integer
#  user_id        :integer          not null
#
# Indexes
#
#  index_images_on_commentable  (imageable_type,imageable_id)
#  index_images_on_user_id      (user_id)
#
# Foreign Keys
#
#  user_id  (user_id => users.id)
#
class Image < ApplicationRecord
  belongs_to :imageable, polymorphic: true
  belongs_to :user

  #for image uploads
  mount_uploader :image_url, ImageUrlUploader
end
