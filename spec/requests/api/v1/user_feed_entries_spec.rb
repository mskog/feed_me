require 'spec_helper'

describe "API:V1:UserFeedEntries", type: :request do
  Given(:user){create :user}
  Given!(:user_feed){create :user_feed, user: user}
  Given!(:feed_entries){create_list :feed_entry, 2, feed: user_feed.feed}

  When{get api_v1_entries_path(user_feed.id, user_email: user.email, user_token: user.authentication_token)}
  Given(:parsed_response){JSON.parse response.body}
  Given(:first_entry){parsed_response['user_feed_entries'].first}

  Then{expect(response.status).to eq 200}
  And{expect(parsed_response['user_feed_entries'].size).to eq 2}
  And{expect(first_entry['title']).to eq feed_entries.first.title}
  And{expect(first_entry['url']).to eq feed_entries.first.url}
  And{expect(first_entry['summary']).to eq feed_entries.first.summary}
  And{expect(first_entry['content']).to eq feed_entries.first.content}
  And{expect(first_entry['author']).to eq feed_entries.first.author}
  And{expect(first_entry['image']).to eq feed_entries.first.image}
  And{expect(first_entry['published_at']).to eq feed_entries.first.published_at}
end
