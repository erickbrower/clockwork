class AddPersonIdToForumThreads < ActiveRecord::Migration
  def change
    add_column :forum_threads, :person_id, :integer
    add_index :forum_threads, :person_id
  end
end
