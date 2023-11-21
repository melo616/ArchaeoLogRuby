class CreateAnnouncements < ActiveRecord::Migration[7.0]
  def change
    create_table :announcements do |t|
      t.string :title
      t.text :body
      t.references :poster, null: false, foreign_key: { to_table: :users }
      t.references :dig, null: false, foreign_key: true

      t.timestamps
    end
  end
end
