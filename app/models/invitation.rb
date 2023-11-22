# == Schema Information
#
# Table name: invitations
#
#  id           :integer          not null, primary key
#  role         :string
#  status       :string           default("pending")
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  dig_id       :integer          not null
#  recipient_id :integer          not null
#  sender_id    :integer          not null
#
# Indexes
#
#  index_invitations_on_dig_id        (dig_id)
#  index_invitations_on_recipient_id  (recipient_id)
#  index_invitations_on_sender_id     (sender_id)
#
# Foreign Keys
#
#  dig_id        (dig_id => digs.id)
#  recipient_id  (recipient_id => users.id)
#  sender_id     (sender_id => users.id)
#
class Invitation < ApplicationRecord
  belongs_to :dig
  belongs_to :sender, class_name: "User", foreign_key: "sender_id"
  belongs_to :recipient, class_name: "User", foreign_key: "recipient_id"

  enum status: { pending: "pending", rejected: "rejected", accepted: "accepted" }

  enum role: {
    lead: 'lead',
    analyst: 'analyst',
    field_worker: 'field worker'
  }, _default: :field_worker
end
