class FeedEntryDecorator < Draper::Decorator
  delegate_all

  def summary_stripped
    h.strip_tags object.summary
  end
end
