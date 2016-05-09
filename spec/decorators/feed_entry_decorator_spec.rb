require 'spec_helper'

describe FeedEntryDecorator do
  subject{described_class.new(feed_entry)}

  describe "#summary_stripped" do
    Given(:feed_entry){build_stubbed :feed_entry, summary: summary}

    When(:result){subject.summary_stripped}

    context "a summary with html tags" do
      Given(:summary){"foo<a href='dsfsdf.com'>barr</a>bar"}
      Then{expect(result).to eq 'foobarrbar'}
    end

    context "with a summary with no html tags" do
      Given(:summary){"Im a little teapot"}
      Then{expect(result).to eq summary}
    end

    context "with a summary that is nil" do
      Given(:summary){nil}
      Then{expect(result).to eq ''}
    end
  end
end
