class Api::V1::UserFeedEntriesController < Api::ApiController
  def index
    user_feed = UserFeed.eager_load(feed: :entries).find(params[:id])
    entries = FeedEntryDecorator.decorate_collection(user_feed.feed.entries.order(id: :desc).page(1).per(20))
    render json: entries, each_serializer: FeedEntrySerializer, meta: meta_attributes(entries)
  end

  private

  def meta_attributes(resource, extra_meta = {})
    {
      current_page: resource.current_page,
      next_page: resource.next_page,
      prev_page: resource.prev_page,
      total_pages: resource.total_pages,
      total_count: resource.total_count
    }.merge(extra_meta)
  end
end
