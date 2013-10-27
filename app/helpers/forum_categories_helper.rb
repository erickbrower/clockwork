module ForumCategoriesHelper

  def new_forum_category_button
    link_button new_forum_category_path do |b| 
      b.text = "#{icon(:plus)} New Forum Category" 
      b.size = :large
      b.option = :primary
    end
  end

end
