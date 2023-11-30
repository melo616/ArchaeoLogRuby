# == Schema Information
#
# Table name: artifacts
#
#  id            :integer          not null, primary key
#  category      :string
#  description   :text
#  material      :string
#  mohs_hardness :decimal(, )
#  site          :string
#  weight        :float
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  dig_id        :integer          not null
#  poster_id     :integer          not null
#
# Indexes
#
#  index_artifacts_on_dig_id     (dig_id)
#  index_artifacts_on_poster_id  (poster_id)
#
# Foreign Keys
#
#  dig_id     (dig_id => digs.id)
#  poster_id  (poster_id => users.id)
#
class Artifact < ApplicationRecord
  belongs_to :dig, counter_cache: true
  belongs_to :poster, class_name: "User", foreign_key: "poster_id"
  
  has_many :images, as: :imageable, dependent: :destroy

  enum category: {
    jewelry: 'jewelry', 
    weaponry: 'weaponry', 
    tool: 'tool', 
    feature: 'feature', 
    pottery: 'pottery', 
    tablet: 'tablet', 
    human_remains: 'human remains', 
    clothing: 'clothing', 
    faunal_remains: 'faunal remains', 
    other: 'other'}

  validate :poster_is_dig_participant

  validates :mohs_hardness, presence: true, numericality: { greater_than_or_equal_to: 0.5, less_than_or_equal_to: 10, message: 'must be between 0.5 and 10' }
  validate :valid_mohs_increment

  def self.ransackable_attributes(auth_object = nil)
    ["created_on", "description", "category"]
  end

  def poster_is_dig_participant
    unless dig.dig_participants.pluck(:participant_id).include? poster.id
      errors.add(:poster, "must be a participant")
    end
  end

  def valid_mohs_increment
    return if mohs_hardness.nil?

    unless (mohs_hardness * 2) % 1 == 0
      errors.add(:mohs_hardness, "must be in increments of 0.5")
    end
  end
end
