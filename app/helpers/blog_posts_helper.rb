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

  def status_label(post)
    case post.status.to_sym
    when :published then "<span class='label label-success'>#{post.status.to_s.humanize}</span>".html_safe
    when :draft then "<span class='label label-warning'>#{post.status.to_s.humanize}</span>".html_safe
    when :raw then "<span class='label label-default'>#{post.status.to_s.humanize}</span>".html_safe
    end
  end
end
