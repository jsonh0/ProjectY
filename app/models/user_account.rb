# == Schema Information
#
# Table name: user_accounts
#
#  id         :bigint           not null, primary key
#  role       :integer
#  account_id :bigint
#  user_id    :bigint
#
# Indexes
#
#  index_user_accounts_on_account_id  (account_id)
#  index_user_accounts_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#  fk_rails_...  (user_id => users.id)
#
class UserAccount < ApplicationRecord
  belongs_to :user
  belongs_to :account
  enum role: { admin: 0, foreign_national: 1, legal: 2 }
end
