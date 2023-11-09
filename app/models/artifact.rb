# == Schema Information
#
# Table name: artifacts
#
#  id            :integer          not null, primary key
#  category      :string
#  description   :text
#  lat           :float
#  lng           :float
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
end
