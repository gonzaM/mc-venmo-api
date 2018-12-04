class PaymentsController < ApiController
  def create
    current_user.payments.create!(payment_params)
    head(:ok)
  end

  private

  def payment_params
    params.permit(:receiver_id, :amount, :description)
  end

  def current_user
    @current_user ||= User.find(params[:user_id])
  end
end
