class Api::V1::UserFeedEntriesController < Api::ApiController
  def index
    entries = FeedEntryDecorator.decorate_collection(scope_with_query.order(id: :desc).page(page).per(20))
    render json: entries, each_serializer: FeedEntrySerializer, meta: meta_attributes(entries)
  end

  private

  def scope_with_query
    _scope = scope
    return _scope unless params.key? :query
    _scope.where("feed_entries.title ILIKE :query OR feed_entries.summary ILIKE :query", query: "%#{params[:query]}%")
  end

  def scope
    if params[:user_feed_id]
      FeedEntry.joins(feed: :user_feeds).where(user_feeds: {id: params[:user_feed_id]})
    else
      FeedEntry.joins(feed: :users).where(users: {id: current_user.id})
    end
  end

  def page
    params[:page] || 1
  end

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
