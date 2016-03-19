class UpdateAllFeedsJob < ActiveJob::Base
  queue_as :default

  def perform
    Feed.find_each do |feed|
      FetchFeedEntriesJob.perform_later feed
    end
  end
end
