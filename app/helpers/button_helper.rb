require 'ostruct'

module ButtonHelper

  def link_button(url, options={})
    opts = OpenStruct.new(options.merge({option: :default}))
    yield opts 
    css = ['btn']
    css.push opts.css_class.split(' ') if opts.css_class
    if opts.size 
      css.push "btn-#{opts.size}"
    end
    css.push "btn-#{opts.option}"
    options = opts.to_h
    options[:class] = css.join(' ')
    text = options.delete(:text)
    link_to text.html_safe, url, options
  end

  def view_url_for(resource)
    url = nil
    if resource.is_a? ActiveRecord::Relation
      rname = resource.name.pluralize.underscore
      url = send "#{rname}_path"
    else
      rname = resource.class.name.underscore
      if resource.respond_to?(:id) && resource.id
        url = send "edit_#{rname}_path", resource
      else 
        url = send "new_#{rname}_path"
      end
    end
    url
  end

  def link_button_for(resource, &block)
    link_button view_url_for(resource), &block
  end

  def grid_edit_button_for(resource)
    link_button_for resource do |b|
      b.size = :sm
      b.option = :info
      b.text = icon :pencil
    end
  end

  def grid_destroy_button_for(resource)
    link_button_for resource do |b|
      b.size = :sm
      b.option = :danger
      b.text = icon :remove
    end
  end

  def split_button(options={})
    opts = OpenStruct.new(options)
    yield opts 
    render partial: 'shared/ui/split_button', locals: { options: opts }
  end
end
