class AddNewerColumnToImmigrationCases < ActiveRecord::Migration[7.0]
  def change
    add_column :immigration_cases, :sent_date, :date

  end
end
