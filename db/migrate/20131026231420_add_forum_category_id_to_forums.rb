class AddForumCategoryIdToForums < ActiveRecord::Migration
  def change
    add_column :forums, :forum_category_id, :integer
    add_index :forums, :forum_category_id
  end
end
