class CreateParticipants < ActiveRecord::Migration[7.0]
  def change
    create_table :participants do |t|
      t.references :dig, null: false, foreign_key: true
      t.references :participant, null: false, foreign_key: { to_table: :users }
      t.string :role

      t.timestamps
    end
    add_index :participants, [:dig_id, :participant_id], unique: true
  end
end
