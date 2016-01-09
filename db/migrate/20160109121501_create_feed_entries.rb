class CreateFeedEntries < ActiveRecord::Migration
  def change
    create_table :feed_entries do |t|
      t.references :feed
      t.string :title
      t.string :link
      t.text :description
    end
  end
end
