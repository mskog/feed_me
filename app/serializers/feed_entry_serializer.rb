class FeedEntrySerializer < ActiveModel::Serializer
  attributes :id, :title, :url, :summary, :content, :author, :image, :published_at

  def summary
    object.summary_stripped.truncate(255)
  end
end
