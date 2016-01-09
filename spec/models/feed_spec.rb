require 'spec_helper'

describe Feed do

  subject{described_class.new(attributes_for(:feed))}

  it{is_expected.to have_many(:entries).class_name("FeedEntry")}

  it{is_expected.to validate_presence_of :title}
  it{is_expected.to validate_presence_of :url}

  it{is_expected.to_not allow_values("sdf", "1234").for(:url)}
  it{is_expected.to allow_values("https://www.test.com", "http://test.com").for(:url)}

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
      And{expect(feed.url).to eq url}
    end

    context "with a feed that already exists" do
      Given!(:existing_feed){create :feed}
      Given(:url){existing_feed.url}
      Then{expect(Feed.count).to eq 1}
      And{expect(feed.id).to eq existing_feed.id}
      And{expect(feed.title).to eq existing_feed.title}
      And{expect(feed.description).to eq existing_feed.description}
      And{expect(feed.url).to eq url}
    end

    context "with a url that gives errors" do
      pending
    end

    context "with a url that is not a feed" do
      pending
    end
  end

  describe "#fetch_entries" do
    subject{create :feed}

    When{subject.fetch_entries}

    context "with an ok response" do
      Given{stub_request(:get, subject.url).to_return(File.new('spec/fixtures/feeds/gamespot_reviews.txt'))}

      context "with a feed without current entries" do
        Given(:first_entry){subject.entries.first}
        Given(:last_entry){subject.entries.last}

        Then{expect(subject.entries.size).to eq 2}
        And{expect(first_entry.title).to eq "Beyond: Two Souls Review"}
        And{expect(first_entry.url).to eq "http://www.gamespot.com/reviews/beyond-two-souls-review/1900-6416326/"}
        And{expect(first_entry.summary).to start_with "<p style"}
        And{expect(first_entry.author).to eq 'Justin Clark'}
        And{expect(first_entry.published_at).to eq DateTime.parse("2015-12-11 18:01:00.000000000 +0000")}

        And{expect(last_entry.title).to eq "Yakuza 5 Review"}
        And{expect(last_entry.url).to eq "http://www.gamespot.com/reviews/yakuza-5-review/1900-6416325/"}
        And{expect(last_entry.summary).to start_with "<p style"}
        And{expect(last_entry.author).to eq 'Miguel Concepcion'}
        And{expect(last_entry.published_at).to eq DateTime.parse("Wed, 09 Dec 2015 18:30:00 UTC +00:00")}
      end

      context "with some of the entries already existing" do
        When do
          subject.entries.first.destroy
          subject.fetch_entries
        end
        Then{expect(subject.entries.size).to eq 2}
      end

      context "with a with all entries already existing" do
        When{subject.fetch_entries}
        Then{expect(subject.entries.size).to eq 2}
      end
    end
  end
end
