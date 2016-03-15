class FeedEntrySerializer < ActiveModel::Serializer
  attributes :id, :title, :url, :summary, :content, :author, :published_at
end
