class Api::V1::UserFeedsController < Api::ApiController
  def index
    render json: UserFeed.includes(:feed).all
  end

  def create
    @user_feed = UserFeed.find_or_create_from_url(current_user, params[:user_feed][:url])
    render json: @user_feed
  end

  def destroy
    UserFeed.find(params[:id]).destroy
    head :ok
  end
end
