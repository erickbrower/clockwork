module BlogPostsHelper
  def blog_post_new_button
    link_to '<span class="glyphicon glyphicon-plus"></span> New Post'.html_safe, new_blog_post_path
  end

  def blog_post_edit_button_for(blog_post)
    link_to "<span class='glyphicon glyphicon-pencil'></span>".html_safe, 
      edit_blog_post_path(blog_post), 
      class: 'btn btn-sm btn-primary'
  end

  def blog_post_delete_button_for(blog_post)
    link_to "<span class='glyphicon glyphicon-remove'></span>".html_safe, 
      blog_post_path(blog_post), 
      method: :delete, 
      class: 'btn btn-sm btn-danger'
  end

  def publish_combo_button_for(blog_post, locals={})
    all = { blog_post: blog_post }
    all.merge(locals)
    render partial: 'blog_posts/publish_combo_button', locals: all
  end

  def blog_post_header_title_for(blog_post)
    link_to blog_post.title, blog_post_path(blog_post)
  end

  def blog_post_sub_header_for(blog_post)
    author_link = link_to "#{blog_post.author.profile.first_name} #{blog_post.author.profile.last_name}", person_path(blog_post.author)
    "By #{author_link} at #{blog_post.created_at}".html_safe
  end

  def status_label_for(blog_post)
    case blog_post.status.to_sym
    when :published then "<span class='label label-success'>#{blog_post.status.to_s.humanize}</span>".html_safe
    when :draft then "<span class='label label-warning'>#{blog_post.status.to_s.humanize}</span>".html_safe
    when :raw then "<span class='label label-default'>#{blog_post.status.to_s.humanize}</span>".html_safe
    end
  end

  def blog_post_comments_for(blog_post)
    render partial: 'blog_posts/comments', locals: { blog_post: blog_post }
  end

  def blog_post_tags_for(blog_post)
    tags = ''
    blog_post.tags.each do |tag|
      tags += "<span class='label label-info'>#{tag}</span> "
    end
    tags.html_safe
  end

  def blog_post_admin_grid_for(blog_posts)
    render partial: 'blog_posts/admin_grid', locals: { blog_posts: blog_posts } 
  end

  def view_blog_button
    link_to '<span class="glyphicon glyphicon-new-window"></span> View Blog'.html_safe, root_path
  end

end
