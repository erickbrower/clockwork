module BlogPostsHelper

  def new_blog_post_button
    link_button new_blog_post_path do |b| 
      b.text = "#{icon(:plus)} New Blog Post" 
      b.size = :large
      b.option = :primary
    end
  end

  def publish_split_button(blog_post)
    edit_text = "Edit #{icon(:pencil, 'pull-right')}"
    edit_link = link_to edit_text.html_safe, edit_blog_post_path(blog_post)
    delete_text = "Delete #{icon(:remove, 'pull-right')}"
    delete_link = link_to delete_text.html_safe, blog_post_path(blog_post), method: :delete
    split_button do |b|
      b.text = 'Publish'
      b.url = publish_blog_post_path blog_post
      b.option = :success
      b.icon = :cog
      b.dropdown_links << edit_link
      b.dropdown_links << delete_link
    end
  end

  def blog_post_sub_header(blog_post)
    author_link = link_to blog_post.author.profile.full_name, person_path(blog_post.author)
    "By #{author_link} on #{formatted_date_for(blog_post.created_at)}".html_safe
  end

  def status_label_for(blog_post)
    case blog_post.status.to_sym
    when :published then "<span class='label label-success'>#{blog_post.status.to_s.humanize}</span>".html_safe
    when :draft then "<span class='label label-warning'>#{blog_post.status.to_s.humanize}</span>".html_safe
    when :raw then "<span class='label label-default'>#{blog_post.status.to_s.humanize}</span>".html_safe
    end
  end

  def blog_post_tags_for(blog_post)
    tags = ''
    blog_post.tags.each do |tag|
      tags += "<span class='label label-info'>#{tag}</span> "
    end
    tags.html_safe
  end

end
