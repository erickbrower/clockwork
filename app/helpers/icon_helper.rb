module IconHelper
  def icon_for(action)
    case action
    when :new then icon(:plus)
    when :edit then icon(:pencil)
    when :destroy then icon(:remove)
    when :show then icon(:search)
    end
  end

  def icon(name, icon_class=nil)
    cls = ['glyphicon']
    cls = ["glyphicon glyphicon-#{name.to_s.dasherize}"]
    cls.push icon_class if icon_class
    content_tag :span, nil, class: cls.join(' ')
  end
end
