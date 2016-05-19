require 'spec_helper'

describe "API:V1:FeedEntries", type: :request do
  Given(:user){create :user}
  Given(:parsed_response){JSON.parse response.body}

  context "with no given user feed" do
    Given(:other_feed){create :feed}
    Given{create :user_feed, feed: other_feed}
    Given{create :feed_entry, feed: other_feed, summary: "<a href='example.com'>foobar</a>"}
    Given!(:user_feed){create :user_feed, user: user}
    Given!(:feed_entry_1){create :feed_entry, feed: user_feed.feed, summary: 'a'*256}

    When{get api_v1_feed_entries_path(user_email: user.email, user_token: user.authentication_token)}

    Then{expect(response.status).to eq 200}
    And{expect(parsed_response['data'].size).to eq 1}
    And{expect(parsed_response['data'].first['attributes']['title']).to eq feed_entry_1.title}
  end

  context "with no given user feed and a query matching by title" do
    Given(:other_feed){create :feed}
    Given{create :user_feed, feed: other_feed}
    Given!(:user_feed){create :user_feed, user: user}
    Given!(:feed_entry_1){create :feed_entry, feed: user_feed.feed, title: 'foobar'}
    Given!(:feed_entry_2){create :feed_entry, feed: user_feed.feed, title: 'some title'}
    Given{create :feed_entry, feed: other_feed, summary: "<a href='example.com'>foobar</a>"}

    Given(:query){'foo'}

    When{get api_v1_feed_entries_path(user_email: user.email, user_token: user.authentication_token, query: query)}

    Then{expect(response.status).to eq 200}
    And{expect(parsed_response['data'].size).to eq 1}
    And{expect(parsed_response['data'].first['attributes']['title']).to eq feed_entry_1.title}
  end

  context "with no given user feed and a query matching by summary" do
    Given(:other_feed){create :feed}
    Given{create :user_feed, feed: other_feed}
    Given!(:user_feed){create :user_feed, user: user}
    Given!(:feed_entry_1){create :feed_entry, feed: user_feed.feed, summary: 'foobar'}
    Given!(:feed_entry_2){create :feed_entry, feed: user_feed.feed, summary: 'some title'}
    Given{create :feed_entry, feed: other_feed, summary: "<a href='example.com'>foobar</a>"}

    Given(:query){'foo'}

    When{get api_v1_feed_entries_path(user_email: user.email, user_token: user.authentication_token, query: query)}

    Then{expect(response.status).to eq 200}
    And{expect(parsed_response['data'].size).to eq 1}
    And{expect(parsed_response['data'].first['attributes']['title']).to eq feed_entry_1.title}
  end

  context "with a given user feed" do
    Given!(:user_feed){create :user_feed, user: user}
    Given!(:feed_entry_1){create :feed_entry, feed: user_feed.feed, summary: 'a'*256}
    Given!(:feed_entry_2){create :feed_entry, feed: user_feed.feed, summary: "<a href='example.com'>foobar</a>"}

    When{get api_v1_feed_entries_path(user_email: user.email, user_token: user.authentication_token, user_feed_id: user_feed.id)}
    Given(:first_entry){parsed_response['data'].first['attributes']}
    Given(:second_entry){parsed_response['data'].second['attributes']}

    Then{expect(response.status).to eq 200}
    And{expect(parsed_response['data'].size).to eq 2}

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

  context "with a given user feed with a query matching by title" do
    Given!(:user_feed){create :user_feed, user: user}
    Given!(:feed_entry_1){create :feed_entry, feed: user_feed.feed, title: 'foobar', summary: 'a'*256}
    Given!(:feed_entry_2){create :feed_entry, feed: user_feed.feed, title: 'some title', summary: "<a href='example.com'>dsf</a>"}

    Given(:query){'foo'}

    When{get api_v1_feed_entries_path(user_email: user.email, user_token: user.authentication_token, user_feed_id: user_feed.id, query: query)}
    Given(:first_entry){parsed_response['data'].first['attributes']}
    Then{expect(response.status).to eq 200}
    And{expect(parsed_response['data'].size).to eq 1}
    And{expect(first_entry['title']).to eq 'foobar'}
  end

  context "with a given user feed with a query matching by summary" do
    Given!(:user_feed){create :user_feed, user: user}
    Given!(:feed_entry_1){create :feed_entry, feed: user_feed.feed, title: 'some title', summary: 'foobar'}
    Given!(:feed_entry_2){create :feed_entry, feed: user_feed.feed, title: 'some title', summary: "sfsdfsfs"}

    Given(:query){'foo'}

    When{get api_v1_feed_entries_path(user_email: user.email, user_token: user.authentication_token, user_feed_id: user_feed.id, query: query)}
    Given(:first_entry){parsed_response['data'].first['attributes']}
    Then{expect(response.status).to eq 200}
    And{expect(parsed_response['data'].size).to eq 1}
    And{expect(first_entry['summary']).to eq 'foobar'}
  end

  context "paginated" do
    Given!(:user_feed){create :user_feed, user: user}
    Given!(:feed_entries){create_list :feed_entry, 30, feed: user_feed.feed}

    When{get api_v1_feed_entries_path(user_email: user.email, user_token: user.authentication_token, user_feed_id: user_feed.id)}
    Then{expect(response.status).to eq 200}
    And{expect(parsed_response['data'].size).to eq 20}
    And{expect(parsed_response['meta']['current_page']).to eq 1}
    And{expect(parsed_response['meta']['next_page']).to eq 2}
    And{expect(parsed_response['meta']['prev_page']).to be_nil}
    And{expect(parsed_response['meta']['total_pages']).to eq 2}
    And{expect(parsed_response['meta']['total_count']).to eq 30}
  end
end
