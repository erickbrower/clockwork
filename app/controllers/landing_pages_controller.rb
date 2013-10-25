class LandingPagesController < ApplicationController
  include Authorizer

  before_filter :add_abilities

  respond_to :html

  layout :set_layout

  def index
    @posts = BlogPost.order('created_at DESC').all
    respond_with @posts
  end

  def forum
    @forums = Forum.all
    respond_with @forums
  end

  private
  def set_layout
    case action_name
    when 'index' then 'blog'
    when 'forum' then 'forum'
    end
  end

  def add_abilities
    abilities << BlogPost
  end
end
