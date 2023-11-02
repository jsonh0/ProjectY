class CreateUserAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :user_accounts do |t|

      t.references :user, foreign_key: true
      t.references :account, foreign_key: true
      t.integer :role
    end
  end
end
