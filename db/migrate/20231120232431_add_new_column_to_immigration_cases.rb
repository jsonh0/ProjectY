class AddNewColumnToImmigrationCases < ActiveRecord::Migration[7.0]
  def change
    add_column :immigration_cases, :approval_date, :date
    add_column :immigration_cases, :received_date, :date
  end
end
