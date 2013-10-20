class CreateForumPosts < ActiveRecord::Migration
  def change
    create_table :forum_posts do |t|
      t.text :body
      t.string :tldr
      t.integer :person_id
      t.integer :forum_thread_id

      t.timestamps
    end
  end
end
