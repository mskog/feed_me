require 'spec_helper'

describe UserFeed do
  it{is_expected.to belong_to :user}
  it{is_expected.to belong_to :feed}
end
