# == Schema Information
#
# Table name: digs
#
#  id              :integer          not null, primary key
#  artifacts_count :integer          default(0)
#  description     :string
#  end_date        :date
#  location        :string
#  name            :string
#  season          :string
#  start_date      :date
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  creator_id      :integer          not null
#
# Indexes
#
#  index_digs_on_creator_id  (creator_id)
#
# Foreign Keys
#
#  creator_id  (creator_id => users.id)
#
class Dig < ApplicationRecord
  belongs_to :creator, class_name: "User"

  has_many :dig_participants, dependent: :destroy
  has_many :users, through: :dig_participants, source: :participant, dependent: :destroy
  has_many :leads, -> { leads }, class_name: "DigParticipant", dependent: :destroy
  has_many :images, as: :imageable, dependent: :destroy
  has_many :artifacts, dependent: :destroy
  
  validates :name, presence: true

  before_create :set_season

  private

  def set_season
    # TODO: logic based on date/location to set season
  end

end
