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

  enum status: {
    Outside_US: 0,
    Visa: 1,
    Pending: 2,
    Greencard: 3,
    Citizen: 4 # New status value
  }

  belongs_to :account
  has_many :immigraiton_case

end
