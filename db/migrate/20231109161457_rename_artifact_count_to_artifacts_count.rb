class RenameArtifactCountToArtifactsCount < ActiveRecord::Migration[7.0]
  def change
        rename_column :digs, :artifact_count, :artifacts_count
  end
end
