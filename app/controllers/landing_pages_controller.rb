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
    @forum_categories = ForumCategory.all
    respond_with @forum_categories
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
