class Feed < ActiveRecord::Base
  has_many :entries, class_name: "FeedEntry"

  validates_presence_of :title
  validates :link, presence: true, url: true
end
