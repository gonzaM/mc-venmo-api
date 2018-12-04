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

FactoryBot.define do
  factory :payment do
    amount      { Faker::Number.decimal(2) }
    description { Faker::Lorem.sentence }
    association :sender, factory: :user
    association :receiver, factory: :user

    after(:build) do |payment, _evaluator|
      create(:friendship, user_a: payment.sender, user_b: payment.receiver)
    end
  end
end
