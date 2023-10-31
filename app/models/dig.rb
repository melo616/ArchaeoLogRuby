# == Schema Information
#
# Table name: digs
#
#  id             :integer          not null, primary key
#  artifact_count :integer          default(0)
#  description    :string
#  end_date       :date
#  location       :string
#  name           :string
#  season         :string
#  start_date     :date
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  creator_id     :integer          not null
#  pi_id          :integer          not null
#
# Indexes
#
#  index_digs_on_creator_id  (creator_id)
#  index_digs_on_pi_id       (pi_id)
#
# Foreign Keys
#
#  creator_id  (creator_id => users.id)
#  pi_id       (pi_id => users.id)
#
class Dig < ApplicationRecord
  belongs_to :creator, class_name: "User"
  belongs_to :pi, class_name: "User"

  validates :name, presence: true
end
