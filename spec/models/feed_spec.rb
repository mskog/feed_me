require 'spec_helper'

describe Feed do

  subject{described_class.new(attributes_for(:feed))}

  it{is_expected.to have_many(:entries).class_name("FeedEntry")}

  it{is_expected.to validate_presence_of :title}
  it{is_expected.to validate_presence_of :link}

  it{is_expected.to_not allow_values("sdf", "1234").for(:link)}
  it{is_expected.to allow_values("https://www.test.com", "http://test.com").for(:link)}

  describe "it has a valid factory" do
    When(:feed) {build(:feed)}
    Then {expect(feed).to be_valid}
  end

  describe ".create_from_url" do
    When(:feed){described_class.create_from_url(url)}

    context "with a url that works" do
      Given do
        stub_request(:get, url).to_return(File.new('spec/fixtures/feeds/gamespot_reviews.txt'))
      end

      Given(:url){"http://www.gamespot.com/feeds/reviews/"}
      Then{expect(feed.title).to eq "GameSpot Reviews"}
      And{expect(feed.description).to start_with 'The latest Reviews'}
      And{expect(feed.link).to eq url}
    end

    context "with a feed that already exists" do
      Given!(:existing_feed){create :feed}
      Given(:url){existing_feed.link}
      # Then{expect(Feed.count).to eq 1}
      Then{expect(feed.id).to eq existing_feed.id}
      And{expect(feed.title).to eq existing_feed.title}
      And{expect(feed.description).to eq existing_feed.description}
      And{expect(feed.link).to eq url}
    end

    context "with a url that gives errors" do
      pending
    end

    context "with a url that is not a feed" do
      pending
    end
  end
end
