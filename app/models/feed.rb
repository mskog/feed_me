class Feed < ActiveRecord::Base
  has_many :entries, class_name: "FeedEntry"

  validates_presence_of :title
  validates :link, presence: true, url: true

  def self.create_from_url(url)
    feed = Feedjira::Feed.fetch_and_parse(url)
    create!(title: feed.title, link: url, description: feed.description)
  end
end
