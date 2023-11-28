class RenameDocumentToDocumentFile < ActiveRecord::Migration[7.0]
  def change
    rename_column :documents, :document, :document_file
  end
end
