class ApplicationController < ActionController::Base
  include Authorizer

  protect_from_forgery with: :exception
  before_filter :set_globals

  around_filter :ensure_person_time_zone, if: :current_person

  def set_globals
    @app_title = 'Clockwork'
    @page_id = "#{controller_name.dasherize}-#{action_name.dasherize}"
    @dashboard_items = {'Blog Posts' => blog_posts_path, 'People' => people_path, 'Forums' => forums_path}
  end

  def ensure_person_time_zone(&block)
    Time.use_zone(current_person.time_zone, &block)
  end

  helper_method :abilities, :can?

end
