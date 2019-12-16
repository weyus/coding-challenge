class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  protected

  #Display errors for AR objects or provided string
  def display_errors(obj_or_string)
    if obj_or_string.respond_to?(:errors)
      "Errors occurred with your request:<br/>#{obj_or_string.errors.full_messages.join("<br/>")}".html_safe
    else
      obj_or_string.html_safe
    end
  end
end
