# == Schema Information
#
# Table name: documents
#
#  id                  :bigint           not null, primary key
#  extracted_text      :string
#  image               :string
#  name                :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  immigration_case_id :bigint           not null
#  uploader_id         :bigint           not null
#
# Indexes
#
#  index_documents_on_immigration_case_id  (immigration_case_id)
#  index_documents_on_uploader_id          (uploader_id)
#
# Foreign Keys
#
#  fk_rails_...  (immigration_case_id => immigration_cases.id)
#  fk_rails_...  (uploader_id => users.id)
#
class Document < ApplicationRecord
  # delete commented out code
  #mount_uploader :image, ImageUploader
  mount_uploader :image, ImageUploader

  belongs_to :immigration_case, class_name: "ImmigrationCase"
  belongs_to :uploader, class_name: "User"
  
end
