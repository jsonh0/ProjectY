# == Schema Information
#
# Table name: accounts
#
#  id         :bigint           not null, primary key
#  name       :citext
#  notes      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Account < ApplicationRecord
  belongs_to :case_id, class_name: "ImmigrationCase"
  belongs_to :uploader, class_name: "User"
  has_many :access
  has_many :user, through: :user
  has_many :foriegn_national
end
