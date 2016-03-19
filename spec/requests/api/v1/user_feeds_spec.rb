require 'spec_helper'

describe "API:V1:UserFeeds", type: :request do
  Given(:user){create :user}
  Given(:params){{}}
  Given(:authenticated_params){params.merge(user_email: user.email, user_token: user.authentication_token)}

  describe "GET index" do
    Given!(:user_feed){create :user_feed, user: user}

    When{get api_v1_feeds_path(authenticated_params)}
    Given(:parsed_response){JSON.parse response.body}
    Given(:first_feed){parsed_response['user_feeds'].first}

    Then{expect(response.status).to eq 200}
    And{expect(first_feed['title']).to eq user_feed.feed.title}
    And{expect(first_feed['url']).to eq user_feed.feed.url}
    And{expect(first_feed['description']).to eq user_feed.feed.description}
  end

  describe "POST create" do
    When{post api_v1_feeds_path(authenticated_params)}

    context "with valid parameters" do
      Given do
        stub_request(:get, url).to_return(File.new('spec/fixtures/feeds/gamespot_reviews.txt'))
      end

      Given(:url){'http://example.com/something.rss'}
      Given(:params){{user_feed: {url: url}}}

      Given(:parsed_response){JSON.parse response.body}
      Given(:expected_feed){parsed_response['user_feed']}

      Then{expect(response.status).to eq 200}
      And{expect(expected_feed['title']).to eq 'GameSpot Reviews'}
    end
  end

  describe "DELETE destroy" do
    Given(:user_feed){create :user_feed, user: user}

    When{delete api_v1_feed_path(user_feed.id, authenticated_params)}

    Then{expect(response.status).to eq 200}
    And{expect(UserFeed.count).to eq 0}
  end
end
