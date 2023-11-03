json.extract! immigration_case, :id, :ForeignNational_id, :case_type, :status, :ReceiptNumber, :NoticeDate, :ExpirationDate, :created_at, :updated_at
json.url immigration_case_url(immigration_case, format: :json)
