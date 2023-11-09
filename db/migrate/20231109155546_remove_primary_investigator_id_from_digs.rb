class RemovePrimaryInvestigatorIdFromDigs < ActiveRecord::Migration[7.0]
  def change
    remove_column :digs, :primary_investigator_id
  end
end
