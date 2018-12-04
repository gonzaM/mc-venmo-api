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

require 'rails_helper'

describe User, type: :model do
  describe 'Associations' do
    it { is_expected.to have_many(:a_friendships) }
    it { is_expected.to have_many(:a_friends) }
    it { is_expected.to have_many(:b_friendships) }
    it { is_expected.to have_many(:b_friends) }
    it { is_expected.to have_one(:payment_account) }
    it { is_expected.to have_many(:payments) }
    it { is_expected.to have_many(:received_payments) }
  end
end
