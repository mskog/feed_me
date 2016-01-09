class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.string :title
      t.string :link
      t.text :description
      t.string :language
      t.timestamps
    end

    add_index :feeds, :link, :unique => true
  end
end
