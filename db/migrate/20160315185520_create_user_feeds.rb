class CreateUserFeeds < ActiveRecord::Migration
  def change
    create_table :user_feeds do |t|
      t.references :user
      t.references :feed
      t.string :name
      t.timestamps
    end

    add_index :user_feeds, :user_id
    add_index :user_feeds, :feed_id
  end
end
