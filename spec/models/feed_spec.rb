require 'spec_helper'

describe Feed do

  subject{described_class.new(attributes_for(:feed))}

  it{is_expected.to validate_presence_of :title}
  it{is_expected.to validate_presence_of :url}

  it{is_expected.to_not allow_values("sdf", "1234").for(:url)}
  it{is_expected.to allow_values("https://www.test.com", "http://test.com").for(:url)}

  describe "it has a valid factory" do
    When(:feed) {build(:feed)}
    Then {expect(feed).to be_valid}
  end
end
