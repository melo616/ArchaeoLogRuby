class CreateImages < ActiveRecord::Migration[7.0]
  def change
    create_table :images do |t|
      t.string :image
      t.string :notes
      t.references :imageable, polymorphic: true, null: false
      t.references :poster, null: false, foreign_key: { to_table: :users }
      t.boolean :cover_photo, default: false
      t.timestamps
    end
  end
end
