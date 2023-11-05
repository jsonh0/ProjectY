class RenameUserAccountToAccess < ActiveRecord::Migration[7.0]
  def change
    rename_table :user_accounts, :access

  end
end
