class AddBodyHtmlToBlogPosts < ActiveRecord::Migration
  def change
    add_column :blog_posts, :body_html, :text
  end
end
