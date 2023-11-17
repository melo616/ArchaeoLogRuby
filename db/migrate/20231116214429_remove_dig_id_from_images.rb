class RemoveDigIdFromImages < ActiveRecord::Migration[7.0]
  def change
    remove_column :images, :dig_id
  end
end
