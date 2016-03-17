class Api::V1::UserFeedsController < Api::ApiController
  def index
    render json: UserFeed.all
  end

  def create
    @user_feed = UserFeed.create_from_url(current_user, params[:user_feed][:url])
    render json: @user_feed
  end
end
