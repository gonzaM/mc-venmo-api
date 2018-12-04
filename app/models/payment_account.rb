# == Schema Information
#
# Table name: payment_accounts
#
#  id                   :integer          not null, primary key
#  balance              :float            default(0.0)
#  payment_method_token :string
#  user_id              :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
# Indexes
#
#  index_payment_accounts_on_user_id  (user_id)
#

class PaymentAccount < ApplicationRecord
  belongs_to :user
end
