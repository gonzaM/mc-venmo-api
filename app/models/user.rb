# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  email      :string
#  full_name  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ApplicationRecord
  has_many :a_friendships, class_name: Friendship.to_s, foreign_key: :user_a_id, dependent: :destroy
  has_many :a_friends, through: :a_friendships, source: :user_b
  has_many :b_friendships, class_name: Friendship.to_s, foreign_key: :user_b_id, dependent: :destroy
  has_many :b_friends, through: :b_friendships, source: :user_a
  has_one :payment_account, dependent: :destroy
  has_many :payments, foreign_key: :sender_id, source: :sender
  has_many :received_payments, class_name: Payment.to_s, foreign_key: :receiver_id

  validates :email, :full_name, presence: true
  validates :email, uniqueness: true

  delegate :balance, to: :payment_account

  after_create :add_payment_account

  def friends
    a_friends + b_friends
  end

  def feed_items
    Payment.feed_items_for(id)
  end

  def add_to_balance(amount)
    payment_account.increment!(:balance, amount)
  end

  def deduct_from_balance(amount)
    payment_account.decrement!(:balance, amount)
  end

  private

  def add_payment_account
    create_payment_account!
  end
end
