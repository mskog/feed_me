class FeedEntry < ActiveRecord::Base
  belongs_to :feed

  validates_presence_of :title
  validates :link, presence: true, url: true
end
