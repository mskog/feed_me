class UserFeed < ActiveRecord::Base
  belongs_to :user
  belongs_to :feed

  def self.create_from_url(user, url)
    feed = Feed.create_from_url(url)
    self.create(user: user, feed: feed)
  end
end
