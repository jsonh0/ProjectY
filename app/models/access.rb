# == Schema Information
#
# Table name: access
#
#  id         :bigint           not null, primary key
#  role       :integer
#  account_id :integer
#  user_id    :bigint
#
# Indexes
#
#  index_access_on_account_id  (account_id)
#  index_access_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Access < ApplicationRecord
  self.table_name = "access" 
  belongs_to :user, class_name: "User", foreign_key: "user_id"
  belongs_to :account, class_name: "Account", foreign_key: "account_id"


  enum role: { admin: 0, foreign_national: 1, legal: 2 }



end
