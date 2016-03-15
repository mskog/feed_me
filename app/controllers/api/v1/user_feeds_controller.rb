class Api::V1::UserFeedsController < Api::ApiController
  def index
    render json:  UserFeed.all
  end
end
