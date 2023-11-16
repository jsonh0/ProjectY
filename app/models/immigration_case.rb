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

  enum case_type: {
    i140: 'I-140',
    i485: 'I-485',
    i131: 'I-131',
    i765: 'I-765',
    i129: 'I-129',
    n400: 'N-400'
  }
end
