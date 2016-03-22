require 'spec_helper'

describe "API:V1:UserFeedEntries", type: :request do
  Given(:user){create :user}
  Given!(:user_feed){create :user_feed, user: user}
  Given!(:feed_entry_1){create :feed_entry, feed: user_feed.feed}
  Given!(:feed_entry_2){create :feed_entry, feed: user_feed.feed, summary: "<a href='example.com'>foobar</a>"}

  When{get api_v1_entries_path(user_feed.id, user_email: user.email, user_token: user.authentication_token)}
  Given(:parsed_response){JSON.parse response.body}
  Given(:first_entry){parsed_response['user_feed_entries'].first}
  Given(:second_entry){parsed_response['user_feed_entries'].second}

  Then{expect(response.status).to eq 200}
  And{expect(parsed_response['user_feed_entries'].size).to eq 2}
  And{expect(first_entry['title']).to eq feed_entry_1.title}
  And{expect(first_entry['url']).to eq feed_entry_1.url}
  And{expect(first_entry['summary']).to eq feed_entry_1.summary}
  And{expect(first_entry['content']).to eq feed_entry_1.content}
  And{expect(first_entry['author']).to eq feed_entry_1.author}
  And{expect(first_entry['image']).to eq feed_entry_1.image}
  And{expect(first_entry['published_at']).to eq feed_entry_1.published_at}
  And{expect(first_entry['published_at']).to eq feed_entry_1.published_at}

  And{expect(second_entry['summary']).to eq 'foobar'}
end
