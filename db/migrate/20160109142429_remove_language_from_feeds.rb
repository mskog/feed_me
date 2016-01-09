class RemoveLanguageFromFeeds < ActiveRecord::Migration
  def change
    remove_column :feeds, :language
  end
end
