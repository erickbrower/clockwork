class LandingPagesController < ApplicationController
  respond_to :html

  layout :set_layout

  def index
    @posts = BlogPost.order('created_at DESC').all
    respond_with @posts
  end

  private
  def set_layout
    case action_name
    when 'index' then 'blog'
    end
  end

end
