class AddForumIdToForumThreads < ActiveRecord::Migration
  def change
    add_column :forum_threads, :forum_id, :integer
    add_index :forum_threads, :forum_id
  end
end
