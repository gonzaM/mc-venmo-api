require 'rails_helper'

describe 'POST users/:user_id', type: :request do
  let(:user) { create(:user) }
  let(:friend) { create(:friendship, user_a: user).user_b }

  context 'when the receiver is a friend' do
    let(:params) { attributes_for(:payment).merge(receiver_id: friend.id) }

    it 'returns success' do
      post user_payments_path(user), params: params, as: :json
      expect(response).to have_http_status(:success)
    end

    it 'creates the payment' do
      expect do
        post user_payments_path(user), params: params, as: :json
      end.to change(Payment, :count).by(1)
    end
  end

  context 'when the receiver is not a friend' do
    let(:another_user) { create(:user) }
    let(:params) { attributes_for(:payment).merge(receiver_id: another_user.id) }

    it 'returns bad request' do
      post user_payments_path(user), params: params, as: :json
      expect(response).to have_http_status(:bad_request)
    end

    it 'does not create the payment' do
      expect do
        post user_payments_path(user), params: params, as: :json
      end.not_to change(Payment, :count)
    end

    it 'returns error message' do
      post user_payments_path(user), params: params, as: :json
      expect(json[:errors]).to include('receiver' => ['should be a friend'])
    end
  end
end
