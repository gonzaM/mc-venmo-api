class UsersController < ApiController
  def balance; end

  def feed
    @feed_items = current_user
                  .feed_items
                  .includes(:sender, :receiver)
                  .page(params[:page])
  end

  private

  def current_user
    @current_user ||= User.find(params[:id])
  end
end
