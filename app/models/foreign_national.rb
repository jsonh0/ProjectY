# == Schema Information
#
# Table name: foreign_nationals
#
#  id         :bigint           not null, primary key
#  address    :string
#  birthday   :date
#  name       :string
#  status     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  account_id :integer
#
class ForeignNational < ApplicationRecord
  validates :name, presence: true
  belongs_to :account, foreign_key: "account_id"
  has_many  :immigration_cases, class_name: "ImmigrationCase", foreign_key: "foreign_nationals_id"

  enum status: {
    "Outside-US": 0,
    Visa: 1,
    Pending: 2,
    Greencard: 3,
    Citizen: 4 # New status value
  }
  def self.ransackable_attributes(auth_object = nil)
    ["account_id", "id", "name"]
  end
  
end
