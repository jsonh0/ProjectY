class CreateForeignNationals < ActiveRecord::Migration[7.0]
  def change
    create_table :foreign_nationals do |t|
      t.string :name
      t.integer :status
      t.date :birthday
      t.string :address

      t.timestamps
    end
  end
end
