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
#  dig_id        :integer
#  poster_id     :integer
#
class Artifact < ApplicationRecord
  belongs_to :dig, counter_cache: true
  belongs_to :poster, class_name: "User", foreign_key: "poster_id"

  validate :poster_is_dig_participant

  def poster_is_dig_participant
    unless dig.dig_participants.pluck(:participant_id).include? poster.id
      errors.add(:poster, "must be a dig participant")
    end
  end
end
