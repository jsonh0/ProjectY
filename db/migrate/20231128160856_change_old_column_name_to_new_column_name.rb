class ChangeOldColumnNameToNewColumnName < ActiveRecord::Migration[7.0]
  def change
    rename_column :documents, :case_id_id, :case_id
  end
end
