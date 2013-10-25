module ForumsHelper

  def new_forum_button
    link_button new_forum_path do |b| 
      b.text = "#{icon(:plus)} New Forum" 
      b.size = :large
      b.option = :primary
    end
  end

end
