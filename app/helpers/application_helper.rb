module ApplicationHelper
  def field_has_errors?(field, errors)
    errors.any? && errors.messages.keys.include?(field.to_sym)
  end
end
