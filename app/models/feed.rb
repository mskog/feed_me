class Feed < ActiveRecord::Base
  has_many :entries, class_name: "FeedEntry"

  validates_presence_of :title
  validates :url, presence: true, url: true

  def self.create_from_url(url)
    find_or_create_by(url: url) do |initialized_feed|
      feedjira_feed = Feedjira::Feed.fetch_and_parse(initialized_feed.url)
      initialized_feed.attributes = {title: feedjira_feed.title, url: url, description: feedjira_feed.description}
    end
  end

  def fetch_entries
    feedjira_feed = Feedjira::Feed.fetch_and_parse(url)
    feedjira_feed.entries.each do |feedjira_entry|
      entries.create_from_feedjira_entry(self, feedjira_entry)
    end
  end
end
