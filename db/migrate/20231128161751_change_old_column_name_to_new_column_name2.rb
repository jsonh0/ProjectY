class ChangeOldColumnNameToNewColumnName2 < ActiveRecord::Migration[7.0]
  def change
    rename_column :documents, :case_id, :immigration_case_id
  end
end
