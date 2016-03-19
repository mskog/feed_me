require 'spec_helper'

describe UpdateAllFeedsJob do
  Given!(:feed1){create :feed}
  Given!(:feed2){create :feed}
  subject{described_class.new}

  Given{expect(FetchFeedEntriesJob).to receive(:perform_later).with(feed1)}
  Given{expect(FetchFeedEntriesJob).to receive(:perform_later).with(feed2)}

  When{subject.perform}
  Then{}
end
