class RemoveCoordsFromArtifact < ActiveRecord::Migration[7.0]
  def change
    remove_column :artifacts, :lat
    remove_column :artifacts, :lng
  end
end
