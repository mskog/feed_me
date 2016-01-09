class Feed < ActiveRecord::Base
  has_many :entries, class_name: "FeedEntry"

  validates_presence_of :title
  validates :link, presence: true, url: true

  def self.create_from_url(url)
    find_or_create_by(link: url) do |initialized_feed|
      feedjira_feed = Feedjira::Feed.fetch_and_parse(url)
      initialized_feed.attributes = {title: feedjira_feed.title, link: url, description: feedjira_feed.description}
    end
  end
end
