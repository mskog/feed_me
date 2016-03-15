require 'spec_helper'

describe "API:V1:UserFeeds", type: :request do
  Given(:user){create :user}
  Given!(:user_feed){create :user_feed, user: user}

  When{get api_v1_feeds_path(user_email: user.email, user_token: user.authentication_token)}
  Given(:parsed_response){JSON.parse response.body}
  Given(:first_feed){parsed_response['user_feeds'].first}

  Then{expect(response.status).to eq 200}
  And{expect(first_feed['title']).to eq user_feed.feed.title}
  And{expect(first_feed['url']).to eq user_feed.feed.url}
  And{expect(first_feed['description']).to eq user_feed.feed.description}
end
