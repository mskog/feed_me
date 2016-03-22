class Api::V1::UserFeedEntriesController < Api::ApiController
  def index
    user_feed = UserFeed.eager_load(feed: :entries).find(params[:id])
    render json: FeedEntryDecorator.decorate_collection(user_feed.feed.entries), each_serializer: FeedEntrySerializer
  end
end
