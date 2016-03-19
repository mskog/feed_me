class FetchFeedEntriesJob < ActiveJob::Base
  queue_as :feeds

  def perform(feed)
    feed.fetch_entries
  end
end
