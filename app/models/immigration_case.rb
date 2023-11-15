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
  #belongs_to :ForeignNational, foreign_key: "foreign_national_id"
  has_many :document

  enum status: {
    I: 0,
    Visa: 1,
    Pending: 2,
    Greencard: 3,
    Citizen: 4 # New status value
  }
end
