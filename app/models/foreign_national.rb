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
    outside_US: 0,
    visa: 1,
    pending: 2,
    greencard: 3,
    citizen: 4 # New status value
  }

  belongs_to :account
  has_many :immigraiton_case

end
