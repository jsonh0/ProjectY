class CreateImmigrationCases < ActiveRecord::Migration[7.0]
  def change
    create_table :immigration_cases do |t|
      t.references :foreign_nationals, null: false, foreign_key: true
      t.integer :case_type
      t.integer :status
      t.string :receipt_number
      t.date :notice_date
      t.date :expiration_date

      t.timestamps
    end
  end
end
