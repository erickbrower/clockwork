module BlogPostsHelper
  def edit_button(post)
    link_to "<span class='glyphicon glyphicon-pencil'></span>".html_safe, 
            edit_blog_post_path(post), 
            class: 'btn btn-sm btn-primary'
  end

  def delete_button(post)
    link_to "<span class='glyphicon glyphicon-remove'></span>".html_safe, 
            blog_post_path(post), 
            method: :delete, 
            class: 'btn btn-sm btn-danger'

  end

end
