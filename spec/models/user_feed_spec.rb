require 'spec_helper'

describe UserFeed do
  it{is_expected.to belong_to :user}
  it{is_expected.to belong_to :feed}

  describe ".find_or_create_from_url" do
    Given(:user){create :user}
    When(:user_feed){described_class.find_or_create_from_url(user, url)}

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

    context "when an identical user feed already exists" do
      Given!(:existing_user_feed){create :user_feed, user: user, feed: create(:feed, url: url)}
      Given(:url){"http://www.gamespot.com/feeds/reviews/"}
      Then{expect(Feed.count).to eq 1}
      And{expect(UserFeed.count).to eq 1}
      And{expect(user_feed).to eq existing_user_feed}
    end
  end
end
