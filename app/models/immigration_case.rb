# == Schema Information
#
# Table name: immigration_cases
#
#  id                   :bigint           not null, primary key
#  case_type            :integer
#  expiration_date      :date
#  notice_date          :date
#  receipt_number       :string
#  status               :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  foreign_nationals_id :bigint           not null
#
# Indexes
#
#  index_immigration_cases_on_foreign_nationals_id  (foreign_nationals_id)
#
# Foreign Keys
#
#  fk_rails_...  (foreign_nationals_id => foreign_nationals.id)
#
class ImmigrationCase < ApplicationRecord
  belongs_to :fn, required: true, class_name: "ForeignNational", foreign_key: "foreign_nationals_id"
  has_many :document

  enum case_type: {
    "I-140": 0,
    "I-485": 1,
    "I-131": 2,
    "I-765": 3,
    "I-129": 4,
    "N-400": 5
  }
end
