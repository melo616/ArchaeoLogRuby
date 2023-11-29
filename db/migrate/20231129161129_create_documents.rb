class CreateDocuments < ActiveRecord::Migration[7.0]
  def change
    create_table :documents do |t|
      t.string :title
      t.string :author
      t.string :document_file
      t.text :notes
      t.string :allowed_roles, array: true, null: false
      t.references :poster, null: false, foreign_key: { to_table: :users}
      t.references :dig, null: false, foreign_key: true

      t.timestamps
    end
  end
end
