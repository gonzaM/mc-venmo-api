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

    context 'when the sender has balance' do
      before do
        user.add_to_balance(params[:amount].to_f)
      end

      it 'deducts balance from sender' do
        post user_payments_path(user), params: params, as: :json
        user.payment_account.reload
        expect(user.balance).to eq 0
      end

      it 'increments balance to receiver' do
        receiver_balance = friend.balance
        post user_payments_path(user), params: params, as: :json
        friend.payment_account.reload
        expect(friend.balance).to eq receiver_balance + params[:amount].to_f
      end
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
