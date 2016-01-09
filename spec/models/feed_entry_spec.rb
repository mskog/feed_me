require 'spec_helper'

describe FeedEntry do
  subject{described_class.new(attributes_for(:feed_entry))}

  it{is_expected.to belong_to(:feed)}

  it{is_expected.to validate_presence_of :title}
  it{is_expected.to validate_presence_of :link}

  it{is_expected.to_not allow_values("sdf", "1234").for(:link)}
  it{is_expected.to allow_values("https://www.test.com", "http://test.com").for(:link)}

  describe "it has a valid factory" do
    When(:feed_entry) {build(:feed_entry)}
    Then {expect(feed_entry).to be_valid}
  end
end
