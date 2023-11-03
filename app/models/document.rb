# == Schema Information
#
# Table name: documents
#
#  id             :bigint           not null, primary key
#  extracted_text :string
#  image          :string
#  name           :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  case_id_id     :bigint           not null
#  uploader_id    :bigint           not null
#
# Indexes
#
#  index_documents_on_case_id_id   (case_id_id)
#  index_documents_on_uploader_id  (uploader_id)
#
# Foreign Keys
#
#  fk_rails_...  (case_id_id => immigration_cases.id)
#  fk_rails_...  (uploader_id => users.id)
#
class Document < ApplicationRecord
  belongs_to :case_id, class_name: "ImmigrationCase"
  belongs_to :uploader, class_name: "User"
end
