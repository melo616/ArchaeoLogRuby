# == Schema Information
#
# Table name: documents
#
#  id            :integer          not null, primary key
#  author        :string
#  document_file :string
#  notes         :text
#  title         :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  dig_id        :integer          not null
#  poster_id     :integer          not null
#
# Indexes
#
#  index_documents_on_dig_id     (dig_id)
#  index_documents_on_poster_id  (poster_id)
#
# Foreign Keys
#
#  dig_id     (dig_id => digs.id)
#  poster_id  (poster_id => users.id)
#
class Document < ApplicationRecord
  belongs_to :poster, class_name: "User", foreign_key: "poster_id"
  belongs_to :dig

  validates :title, presence: true

  mount_uploader :document_file, DocumentFile
end
