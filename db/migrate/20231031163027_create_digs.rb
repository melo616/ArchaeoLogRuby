class CreateDigs < ActiveRecord::Migration[7.0]
  def change
    create_table :digs do |t|
      t.date :start_date
      t.date :end_date
      t.string :location
      t.string :name
      t.string :description
      t.string :season
      t.integer :artifact_count, default: 0
      t.references :creator, null: false, foreign_key: { to_table: :users}
      t.references :primary_investigator, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
