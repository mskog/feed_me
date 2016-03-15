class Api::V1::UserFeedEntriesController < Api::ApiController
  def index
    user_feed = UserFeed.eager_load(feed: :entries).find(params[:id])
    render json: user_feed.feed.entries
  end
end
