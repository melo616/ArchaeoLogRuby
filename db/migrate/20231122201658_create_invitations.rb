class CreateInvitations < ActiveRecord::Migration[7.0]
  def change
    create_table :invitations do |t|
      t.string :role
      t.string :status, default: "pending"
      t.references :dig, null: false, foreign_key: true
      t.references :sender, null: false, foreign_key: { to_table: :users}
      t.references :recipient, null: false, foreign_key: { to_table: :users}

      t.timestamps
    end
  end
end
