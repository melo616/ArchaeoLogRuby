class CreateArtifacts < ActiveRecord::Migration[7.0]
  def change
    create_table :artifacts do |t|
      t.float :lat
      t.float :lng
      t.text :description
      t.string :material
      t.decimal :mohs_hardness
      t.float :weight
      t.integer :dig_id
      t.string :site
      t.integer :poster_id

      t.timestamps
    end
  end
end
