class ApplicationController < ActionController::Base
  include Authorizer

  protect_from_forgery with: :exception
  before_filter :set_globals

  def set_globals
    @app_title = 'Clockwork'
    @page_id = "#{controller_name.dasherize}-#{action_name.dasherize}"
  end

  helper_method :abilities, :can?

end
