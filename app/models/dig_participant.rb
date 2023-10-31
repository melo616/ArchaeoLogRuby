# == Schema Information
#
# Table name: dig_participants
#
#  id             :integer          not null, primary key
#  role           :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  dig_id         :integer          not null
#  participant_id :integer          not null
#
# Indexes
#
#  index_dig_participants_on_dig_id          (dig_id)
#  index_dig_participants_on_participant_id  (participant_id)
#
# Foreign Keys
#
#  dig_id          (dig_id => digs.id)
#  participant_id  (participant_id => users.id)
#
class DigParticipant < ApplicationRecord
  belongs_to :dig
  belongs_to :participant
end
