require 'ostruct'

module ResourceHelper

  def view_url_for(resource, delete=false)
    url = nil
    if resource.is_a? ActiveRecord::Relation
      rname = resource.name.pluralize.underscore
      url = send "#{rname}_path"
    elsif delete
      rname = resource.class.name.underscore
      url = send "#{rname}_path", resource
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

  def link_button_for(resource, delete=false, &block)
    link_button view_url_for(resource, delete), &block
  end

  def grid_edit_button_for(resource)
    link_button_for resource do |b|
      b.size = :sm
      b.option = :info
      b.text = icon :pencil
    end
  end

  def grid_destroy_button_for(resource)
    link_button_for resource, true do |b|
      b.size = :sm
      b.option = :danger
      b.text = icon :remove
      b.method = :delete
    end
  end
end
