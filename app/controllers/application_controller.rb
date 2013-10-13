class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :set_globals

  def set_globals
    @app_title = 'Clockwork'
  end

  helper_method :abilities, :can?

  def abilities
    @abilites ||= Six.new
  end

  def can?(object, action, subject)
    abilities.allowed?(object, action, subject)
  end
end
