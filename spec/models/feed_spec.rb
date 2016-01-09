require 'spec_helper'

describe Feed do

  subject{described_class.new(attributes_for(:feed))}

  it{is_expected.to validate_presence_of :title}
  it{is_expected.to validate_presence_of :url}

  describe "it has a valid factory" do
    When(:feed) {build(:feed)}
    Then {expect(feed).to be_valid}
  end
end
