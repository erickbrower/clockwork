module ForumsHelper

  def new_forum_button
    link_button new_forum_path do |b| 
      b.text = "#{icon(:plus)} New Forum" 
      b.size = :large
      b.option = :primary
    end
  end

  def forum_header_nav
    header_nav do |h|
      h.option = :pills
      h.wrapper_classes.push "pull-right"
      h.items << UI::NavListItem.new({ 
        body: link_to('Dashboard', forum_home_path), 
        active: request.url.include?(forum_home_path)
      })
      h.items << UI::NavListItem.new({
        body: link_to('Log Out', '#')
      })
    end
  end

end
