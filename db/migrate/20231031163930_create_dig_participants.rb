class CreateDigParticipants < ActiveRecord::Migration[7.0]
  def change
    create_table :dig_participants do |t|
      t.references :dig, null: false, foreign_key: true
      t.references :participant, null: false, foreign_key: { to_table: :users }
      t.string :role

      t.timestamps
    end
  end
end
