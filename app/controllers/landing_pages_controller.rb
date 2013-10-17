class LandingPagesController < ApplicationController
  respond_to :html

  def index
    @posts = BlogPost.order('created_at DESC').all
    respond_with @posts
  end

end
