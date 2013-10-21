module ForumThreadsHelper
  def render_forum_thread_tags(forum_thread)
    tags = ''
    forum_thread.tags.each do |tag|
      tags += "<span class='label label-info'>#{tag}</span> "
    end
    tags.html_safe
  end

  def render_sample_forum_thread_tag(forum_thread, num=1)
    tags = ''
    num.times do
      tags += "<span class='label label-info'>#{forum_thread.tags.sample}</span> "
    end
    tags.html_safe
  end
end
