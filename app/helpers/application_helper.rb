module ApplicationHelper
  def field_has_errors?(field, errors)
    errors.any? && errors.messages.keys.include?(field.to_sym)
  end

  def formatted_date_for(datetime)
    datetime.to_formatted_s(:long)
  end

  private 
  def delegate_to_helper(method, res)
    res_name = res.respond_to?(:each) ? res.first.class.name : res.class.name
    send("#{res_name.underscore}_#{method}", res)
  end


end
