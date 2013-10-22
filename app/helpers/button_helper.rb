module ButtonHelper
  [:new, :edit, :destroy].each do |btn_action|

    define_method "#{btn_action}_button_for" do |resource, options={}|
      options[:class] = 'btn btn-default'
      build_button btn_action, resource, options
    end

    [:large, :small, :extra_small].each do |btn_size|
      [:primary, :warning, :danger, :info].each do |btn_color|
        define_method "#{btn_action}_#{btn_size}_#{btn_color}_button_for" do |resource, options={}|
          build_button btn_action, resource, options, btn_size, btn_color
        end
      end
    end
  end

  def grid_edit_button_for(resource)
    edit_small_info_button_for resource, show_action: false, show_resource_name: false
  end

  def grid_destroy_button_for(resource)
    destroy_small_danger_button_for resource, show_action: false, show_resource_name: false
  end

  def button_with_dropdown(btn, dropdown)
    content = ''
    content +=  button_tag type: 'button', class: "btn #{btn[:css_class]}" do
        link_to(btn[:text], btn[:url], btn[:opts])
    end
    content += button_tag type: 'button', class: "btn #{btn[:css_class]} dropdown-toggle", data: { toggle: 'dropdown' } do
        icon(dropdown[:icon] || :cog)
    end
    list_content = ''
    dropdown[:content].each do |c|
      list_content += content_tag :li do
        link_to c[:text].html_safe, c[:url], c[:opts]
      end
    end

    content += content_tag :ul, list_content.html_safe, class: 'dropdown-menu', role: 'menu'
    content_tag :div, content.html_safe, class: 'btn-group btn-with-dropdown'
  end

  private

  def button_for(action, resource, options)
    rname = get_resource_name resource
    if action == :new
      link_url = send("#{action}_#{rname.underscore}_path")
    elsif action == :destroy
      link_url = send("#{rname.underscore}_path", resource)
      options[:method] = :destroy
    else
      link_url = send("#{action}_#{rname.underscore}_path", resource)
    end
    link_to options[:text].html_safe,
      link_url,
      options 
  end

  def build_button_text(action, rname, show_icon, show_action, show_resource_name)
    btn_text = []
    btn_text.push icon_for(action) if show_icon
    btn_text.push action.to_s.titleize if show_action
    btn_text.push rname.titleize if show_resource_name
    btn_text.join ' '
  end

  def get_button_size_class(size)
    btn_class = ['btn']
    case size
    when :large then btn_class.push 'btn-lg'
    when :small then btn_class.push 'btn-sm'
    when :extra_small then btn_class.push 'btn-xs'
    end
  end

  def get_button_color_class(color)
    case color
    when :primary then 'btn-primary'
    when :warning then 'btn-warning'
    when :danger then 'btn-danger'
    when :info then 'btn-info'
    end
  end

  def get_resource_name(resource)
    resource.respond_to?(:each) ? resource.first.class.name : resource.class.name
  end

  def build_button(btn_action, resource, options, btn_size=nil, btn_color=nil)
    rname = get_resource_name resource
    btn_class = options[:class].split ' '
    btn_class.push get_button_size_class(btn_size) if btn_size
    btn_class.push get_button_color_class(btn_color) if btn_color
    options[:class] = btn_class.join ' '
    options[:text] ||= build_button_text(btn_action, 
                                         rname, 
                                         options.fetch(:show_icon, true), 
                                         options.fetch(:show_action, true), 
                                         options.fetch(:show_resource_name, true))
    button_for btn_action, resource, options 
  end
end
