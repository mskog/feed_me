class UserFeedSerializer < ActiveModel::Serializer
  attributes :id, :title, :url, :description

  delegate :title, :url, :description, to: 'object.feed'
end
