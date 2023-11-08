class AddUniqueConstraintToDigParticipants < ActiveRecord::Migration[7.0]
  def change
    add_index :dig_participants, [:dig_id, :participant_id], unique: true
  end
end
