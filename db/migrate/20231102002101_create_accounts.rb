class CreateAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :accounts do |t|
      t.citext :name
      t.string :notes

      t.timestamps
    end
  end
end
