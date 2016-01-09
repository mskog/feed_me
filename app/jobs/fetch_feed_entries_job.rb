class FetchFeedEntriesJob < ActiveJob::Base
  queue_as :default

  def perform(feed)
    feed.fetch_entries
  end
end
