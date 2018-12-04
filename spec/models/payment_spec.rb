# == Schema Information
#
# Table name: payments
#
#  id          :integer          not null, primary key
#  amount      :float
#  description :string
#  sender_id   :integer          not null
#  receiver_id :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_payments_on_receiver_id  (receiver_id)
#  index_payments_on_sender_id    (sender_id)
#

require 'rails_helper'

describe Payment, type: :model do
  subject { build(:payment) }

  describe 'Validations' do
    it do
      is_expected.to validate_numericality_of(:amount)
        .is_greater_than(0)
        .is_less_than(1000)
    end
  end
end
