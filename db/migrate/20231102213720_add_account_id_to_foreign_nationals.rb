class AddAccountIdToForeignNationals < ActiveRecord::Migration[7.0]
  def change
    add_column :foreign_nationals, :account_id, :integer
  end
end
