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
  has_many :cases, class_name: "ImmigrationCase"

  has_many :accesses
  has_many :users, through: :accesses
  has_many :foreign_nationals
  accepts_nested_attributes_for :accesses
  def account_params
    params.require(:account).permit(:name, :notes, access_attributes: [:role])
  end

  def self.ransackable_attributes(auth_object = nil)
    ["id", "name", "notes"]
  end
  def self.ransackable_associations(auth_object = nil)
    [ "foreign_nationals" ]
  end

end
