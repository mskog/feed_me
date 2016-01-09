class CreateFeedEntries < ActiveRecord::Migration
  def change
    create_table :feed_entries do |t|
      t.references :feed
      t.string :title
      t.string :url
      t.text :summary
      t.text :content
      t.string :author
    end
  end
end
