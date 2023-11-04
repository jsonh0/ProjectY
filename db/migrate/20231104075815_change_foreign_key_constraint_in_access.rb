class ChangeForeignKeyConstraintInAccess < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :access, :accounts  # Remove existing foreign key constraint
    change_column :access, :account_id, :integer, null: true  # Modify the column to allow null values
  end
end
