module ApplicationHelper
  # Make placeholder text with error message if there is any validation error
  def placeholder_with_error(object, attribute, title)
    msg = title.humanize
    if object.errors.any? && object.errors.messages[attribute]
      msg += " #{object.errors.messages[attribute].join(', ')}"
    end
    msg
  end
end
