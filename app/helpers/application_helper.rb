module ApplicationHelper
  def field_has_errors?(field, errors)
    errors.any? && errors.messages.keys.include?(field.to_sym)
  end

  def formatted_date_for(datetime)
    datetime.to_formatted_s(:long)
  end

  [:admin_grid, :edit_button, :delete_button, :comments].each do |element|
    define_method "#{element}_for" do |resource|
      delegate_to_helper(__method__, resource)
    end

    define_method :new_button_for do |resource|
      delegate_to_helper(:new_button, resource, false)
    end
  end

  private 
  def delegate_to_helper(method, res, send_args=true)
    res_name = res.respond_to?(:each) ? res.first.class.name : res.class.name
    if send_args
      send("#{res_name.underscore}_#{method}", res)
    else
      send("#{res_name.underscore}_#{method}")
    end
  end
end
