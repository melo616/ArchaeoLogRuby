class AddFoundDateToArtifacts < ActiveRecord::Migration[7.0]
  def change
    add_column :artifacts, :found_date, :date
  end
end
