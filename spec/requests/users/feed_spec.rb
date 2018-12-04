require 'rails_helper'

describe 'GET users/:id/feed', type: :request do
  let(:user)      { create(:user) }
  let(:friend_1)  { create(:friendship, user_a: user).user_b }
  let(:friend_2)  { create(:friendship, user_b: user).user_a }

  context 'when there are no payments' do
    before do
      get feed_user_path(user), as: :json
    end

    it 'returns success' do
      expect(response).to have_http_status(:success)
    end

    it 'returns empty feed' do
      expect(json[:feed].count).to eq 0
    end
  end

  context 'when there are payments' do
    let!(:my_payment)         { create :payment, sender: user }
    let!(:payment_1)          { create :payment, sender: friend_1 }
    let!(:payment_2)          { create :payment, receiver: friend_2 }
    let(:feed_items_response) { json[:feed].map { |item| item[:id] } }

    before do
      get feed_user_path(user), as: :json
    end

    it 'returns success' do
      expect(response).to have_http_status(:success)
    end

    it 'includes my payments' do
      expect(feed_items_response).to include(my_payment.id)
    end

    it 'includes my friends\' payments list' do
      expect(feed_items_response).to include(payment_1.id, payment_2.id)
    end
  end
end
