class CreateArtifacts < ActiveRecord::Migration[7.0]
  def change
    create_table :artifacts do |t|
      t.string :material
      t.string :category
      t.text :description
      t.decimal :mohs_hardness
      t.float :weight
      t.string :site
      t.references :dig, null: false, foreign_key: true
      t.references :poster, null: false, foreign_key: { to_table: :users}

      t.timestamps
    end
  end
end
