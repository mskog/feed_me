class FeedEntry < ActiveRecord::Base
  # TODO invalid without published_at present?
  belongs_to :feed

  validates_presence_of :title
  validates :url, presence: true, url: true

  def self.create_from_feedjira_entry(feed, feedjira_entry)
    create!(
      feed: feed,
      title: feedjira_entry.title,
      url: feedjira_entry.url,
      author: feedjira_entry.author,
      summary: feedjira_entry.summary,
      published_at: feedjira_entry.published,
    )
  end
end
