class FeedEntrySerializer < ActiveModel::Serializer
  attributes :id, :title, :url, :summary, :content, :author, :image, :published_at
end
