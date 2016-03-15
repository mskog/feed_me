class AddTimeStampsToFeedEntries < ActiveRecord::Migration
  def change
    add_column(:feed_entries, :created_at, :datetime)
    add_column(:feed_entries, :updated_at, :datetime)
  end
end
