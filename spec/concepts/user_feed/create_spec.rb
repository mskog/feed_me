require 'spec_helper'

describe UserFeed::Create do
  Given(:user){create :user}
  When(:user_feed){described_class.(current_user: user, feed: {url: url}).model}

  context "with a url that works" do
    Given do
      stub_request(:get, url).to_return(File.new('spec/fixtures/feeds/gamespot_reviews.txt'))
    end

    Given(:url){"http://www.gamespot.com/feeds/reviews/"}
    Then{expect(user_feed.feed.title).to eq "GameSpot Reviews"}
    And{expect(user_feed.feed.description).to start_with 'The latest Reviews'}
    And{expect(user_feed.feed.url).to eq url}
  end

  context "with a feed that already exists" do
    Given!(:existing_feed){create :feed}
    Given(:url){existing_feed.url}
    Then{expect(Feed.count).to eq 1}
    And{expect(user_feed.feed.id).to eq existing_feed.id}
    And{expect(user_feed.feed.title).to eq existing_feed.title}
    And{expect(user_feed.feed.description).to eq existing_feed.description}
    And{expect(user_feed.feed.url).to eq url}
  end
end
