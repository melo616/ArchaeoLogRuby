class RenameCommentableToImageable < ActiveRecord::Migration[7.0]
  def change
    rename_column :images, :commentable_type, :imageable_type
    rename_column :images, :commentable_id, :imageable_id
  end
end
