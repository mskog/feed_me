class FeedEntryDecorator < Draper::Decorator
  delegate_all

  def summary_stripped
    h.strip_tags object.summary.to_s
  end
end
