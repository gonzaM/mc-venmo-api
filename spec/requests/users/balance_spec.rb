require 'rails_helper'

describe 'GET users/:id/balance', type: :request do
  let!(:user) { create(:user) }

  before do
    user.payment_account.update!(balance: 100)
    get balance_user_path(user), as: :json
  end

  it 'returns success' do
    expect(response).to have_http_status(:success)
  end

  it 'returns balance' do
    expect(json[:balance]).to eq 100
  end
end
