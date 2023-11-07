class AddCategoryToArtifact < ActiveRecord::Migration[7.0]
  def change
    add_column :artifacts, :category, :string
  end
end
