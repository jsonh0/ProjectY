json.extract! document, :id, :case_id, :name, :image, :extracted_text, :uploader_id, :created_at, :updated_at
json.url document_url(document, format: :json)
