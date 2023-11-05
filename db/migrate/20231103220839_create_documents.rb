class CreateDocuments < ActiveRecord::Migration[7.0]
  def change
    create_table :documents do |t|
      t.references :case_id, null: false, foreign_key: true, foreign_key: {to_table: :immigration_cases}
      t.string :name
      t.string :image
      t.string :extracted_text
      t.references :uploader, null: false, foreign_key: true, foreign_key: {to_table: :users}

      t.timestamps
    end
  end
end
