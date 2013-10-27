module UIHelper
  def split_button(args={})
    btn = UI::SplitButton.new args
    yield btn 
    render btn
  end

  def media_list(args={})
    list = UI::MediaList.new args
    yield list
    render list
  end

  def header_nav(args={})
    header = UI::HeaderNav.new args
    yield header
    render header
  end

  def link_button(url, args={})
    opts = OpenStruct.new(args.merge({option: :default}))
    yield opts 
    css = ['btn']
    css.push opts.css_class.split(' ') if opts.css_class
    if opts.size 
      css.push "btn-#{opts.size}"
    end
    css.push "btn-#{opts.option}"
    args = opts.to_h
    args[:class] = css.join(' ')
    text = args.delete(:text)
    link_to text.html_safe, url, args
  end
end
