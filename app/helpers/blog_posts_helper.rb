module BlogPostsHelper

  def publish_button_with_dropdown(blog_post)
    return unless can? current_person, :update_blog_post, blog_post
    btn = {}
    btn[:text] = 'Publish'
    btn[:url] = publish_blog_post_path blog_post
    btn[:css_class] = 'btn-success'
    if blog_post.published? 
      btn[:text] = 'Unpublish'
      btn[:url]= unpublish_blog_post_path blog_post
      btn[:css_class]= 'btn-warning'
    end
    dropdown = {
      content: [
        {
          text: "Edit #{icon(:pencil, 'pull-right')}",
          url: edit_blog_post_path(blog_post),
          opts: {}
        },
        {
          text: "Delete #{icon(:remove_circle, 'pull-right')}",
          url: blog_post_path(blog_post),
          opts: { method: :delete }
        } 
      ]
    }
    button_with_dropdown(btn, dropdown)
  end

  def blog_post_sub_header(blog_post)
    author_link = link_to blog_post.author.profile.full_name, person_path(blog_post.author)
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

end
