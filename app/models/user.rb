class User < ActiveRecord::Base
  acts_as_token_authenticatable
  devise :database_authenticatable, :trackable, :validatable

  has_many :feeds, through: :user_feeds
  has_many :user_feeds
end
