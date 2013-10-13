class AddPersonIdToBlogPosts < ActiveRecord::Migration
  def change
    add_column :blog_posts, :person_id, :integer
    add_index :blog_posts, :person_id
  end
end
