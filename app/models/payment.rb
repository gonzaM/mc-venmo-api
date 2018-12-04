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

class Payment < ApplicationRecord
  MIN_AMOUNT = 0
  MAX_AMOUNT = 1000

  belongs_to :sender, class_name: User.to_s
  belongs_to :receiver, class_name: User.to_s

  validates :amount, numericality: { greater_than: MIN_AMOUNT, less_than: MAX_AMOUNT }
  validate :receiver_is_friend

  after_create :transfer_money

  scope :feed_items_for, (lambda do |user_id|
    ids = User.find(user_id).friends.map(&:id) << user_id
    where(sender: ids).or(where(receiver: ids))
      .order(id: :desc)
  end)

  paginates_per 10

  def feed_title
    "#{sender.full_name} paid #{receiver.full_name} on #{created_at}"
  end

  private

  def receiver_is_friend
    return if sender.friends.include?(receiver)

    errors.add(:receiver, I18n.t('api.payments.receiver.friend_required'))
  end

  def transfer_money
    MoneyTransferService.new(sender, receiver).transfer(amount)
  end
end
