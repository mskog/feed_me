require 'spec_helper'

describe User do
  it{is_expected.to have_many(:user_feeds)}
  it{is_expected.to have_many(:feeds)}
end
