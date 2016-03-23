require 'spec_helper'

describe "API:V1:UserFeedEntries", type: :request do
  Given(:user){create :user}
  Given!(:user_feed){create :user_feed, user: user}
  Given(:parsed_response){JSON.parse response.body}

  context "simple" do
    Given!(:feed_entry_1){create :feed_entry, feed: user_feed.feed, summary: 'a'*256}
    Given!(:feed_entry_2){create :feed_entry, feed: user_feed.feed, summary: "<a href='example.com'>foobar</a>"}

    When{get api_v1_entries_path(user_feed.id, user_email: user.email, user_token: user.authentication_token)}
    Given(:first_entry){parsed_response['user_feed_entries'].first}
    Given(:second_entry){parsed_response['user_feed_entries'].second}

    Then{expect(response.status).to eq 200}
    And{expect(parsed_response['user_feed_entries'].size).to eq 2}

    And{expect(first_entry['summary']).to eq 'foobar'}

    And{expect(second_entry['title']).to eq feed_entry_1.title}
    And{expect(second_entry['url']).to eq feed_entry_1.url}
    And{expect(second_entry['summary']).to eq feed_entry_1.summary.truncate(255)}
    And{expect(second_entry['content']).to eq feed_entry_1.content}
    And{expect(second_entry['author']).to eq feed_entry_1.author}
    And{expect(second_entry['image']).to eq feed_entry_1.image}
    And{expect(second_entry['published_at']).to eq feed_entry_1.published_at}
    And{expect(second_entry['published_at']).to eq feed_entry_1.published_at}

  end

  context "paginated" do
    Given!(:feed_entries){create_list :feed_entry, 30, feed: user_feed.feed}

    When{get api_v1_entries_path(user_feed.id, user_email: user.email, user_token: user.authentication_token)}
    Then{expect(response.status).to eq 200}
    And{expect(parsed_response['user_feed_entries'].size).to eq 20}
    And{expect(parsed_response['meta']['current_page']).to eq 1}
    And{expect(parsed_response['meta']['next_page']).to eq 2}
    And{expect(parsed_response['meta']['prev_page']).to be_nil}
    And{expect(parsed_response['meta']['total_pages']).to eq 2}
    And{expect(parsed_response['meta']['total_count']).to eq 30}
  end
end
