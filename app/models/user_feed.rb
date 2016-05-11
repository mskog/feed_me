class UserFeed < ActiveRecord::Base
  belongs_to :user
  belongs_to :feed

  def self.find_or_create_from_url(user, url)
    feed = Feed.create_from_url(url)
    self.find_or_create_by(user: user, feed: feed)
  end
end
