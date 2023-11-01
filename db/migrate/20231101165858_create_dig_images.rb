class CreateDigImages < ActiveRecord::Migration[7.0]
  def change
    create_table :dig_images do |t|
      t.string :image_url
      t.string :notes
      t.references :dig_id, null: false, foreign_key: true
      t.references :user_id, null: false, foreign_key: true
      t.boolean :cover_photo, default: false
      t.timestamps
    end
  end
end
