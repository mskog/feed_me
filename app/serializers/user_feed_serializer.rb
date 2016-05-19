class UserFeedSerializer < ActiveModel::Serializer
  type :feed

  attributes :id, :title, :url, :description

  delegate :title, :url, :description, to: 'object.feed'
end
