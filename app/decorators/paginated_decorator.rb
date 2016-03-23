class PaginatedDecorator < Draper::CollectionDecorator
  delegate :current_page, :total_pages, :prev_page, :next_page, :limit_value, :total_count, :offset_value, :last_page?, :model_name
end
