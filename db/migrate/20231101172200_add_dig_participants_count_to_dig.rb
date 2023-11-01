class AddDigParticipantsCountToDig < ActiveRecord::Migration[7.0]
  def change
    add_column :digs, :integer, :string
  end
end
