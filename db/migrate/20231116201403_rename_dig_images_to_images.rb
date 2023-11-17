class RenameImagesToImages < ActiveRecord::Migration[7.0]
  def change
    rename_table :images, :images
  end
end
