require 'spec_helper'

describe FetchFeedEntriesJob, type: :job do
  Given(:feed){create :feed}

  Given do
    stub_request(:get, feed.url).to_return(File.new('spec/fixtures/feeds/gamespot_reviews.txt'))
  end

  When{subject.perform(feed)}
  Then{expect(feed.entries.size).to eq 2}
end
