module ApplicationHelper
  def field_has_errors?(field, errors)
    errors.any? && errors.messages.keys.include?(field.to_sym)
  end

  def formatted_date_for(datetime)
    datetime.to_formatted_s(:long)
  end

  def admin_grid_for(resources)
    send("#{resources.first.class.name.underscore}_admin_grid_for", resources)
  end

  def new_button_for(resource)
    send("#{resource.class.name.underscore}_new_button")
  end

  def edit_button_for(resource)
    send("#{resource.class.name.underscore}_edit_button_for", resource)
  end

  def delete_button_for(resource)
    send("#{resource.class.name.underscore}_delete_button_for", resource)
  end
end
