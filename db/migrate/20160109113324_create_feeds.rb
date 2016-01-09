class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.string :title
      t.string :url
      t.text :description
      t.timestamps
    end

    add_index :feeds, :url, :unique => true
  end
end
