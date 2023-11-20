# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  bio                    :text
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string
#  last_name              :string
#  private                :boolean
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :created_digs, class_name: "Dig", foreign_key: "creator_id"
  has_many :created_artifacts, class_name: "Artifact", foreign_key: "poster_id"
  has_many :dig_participants, foreign_key: "participant_id"
  has_many :digs, through: :dig_participants

  has_many :announcements

  validates :first_name, presence: true
  validates :last_name, presence: true
end
