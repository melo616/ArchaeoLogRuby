class CreateImages < ActiveRecord::Migration[7.0]
  def change
    create_table :images do |t|
      t.string :image_url
      t.string :notes
      t.references :dig, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.boolean :cover_photo, default: false
      t.timestamps
    end
  end
end
