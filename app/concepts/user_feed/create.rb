class UserFeed::Create < Trailblazer::Operation
  def process(params)
    feed = ::Feed.create_from_url(params[:feed][:url])
    @model = UserFeed.create(user: params[:current_user], feed: feed)
  end
end
