class BlogPostsController < ApplicationController
  respond_to :html

  before_filter :authenticate_person!, except: [:index, :show]
  before_filter :add_abilities

  layout :set_layout

  def index
    @posts = BlogPost.all
    head(401) and return unless can?(current_person, :view_blog_post, @posts.first)
    respond_with @posts
  end

  def new
    @post = BlogPost.new
    head(401) and return unless can?(current_person, :create_blog_post, @post)
    respond_with @post
  end

  def create
    @post = BlogPost.new post_params
    head(401) and return unless can?(current_person, :create_blog_post, @post)
    @post.author = current_person
    flash[:notice] = 'Blog Post was saved successfully!' if @post.save
    respond_with @post
  end

  def edit
    @post = BlogPost.find params[:id]
    head(401) and return unless can?(current_person, :update_blog_post, @post)
    respond_with @post
  end

  def update
    @post = BlogPost.find params[:id]
    head(401) and return unless can?(current_person, :update_blog_post, @post)
    if @post.update_attributes post_params
      flash[:notice] = 'Blog Post was updated successfully!'
    end
    respond_with @post
  end

  def show
    @post = BlogPost.find params[:id]
    head(401) and return unless can?(current_person, :view_blog_post, @post)
    respond_with @post
  end

  def destroy
    @post = BlogPost.find params[:id]
    head(401) and return unless can?(current_person, :destroy_blog_post, @post)
    @post.delete
    respond_with @post
  end

  def publish
    @post = BlogPost.find params[:id]
    head(401) and return unless can?(current_person, :update_blog_post, @post)
    @post.publish
    redirect_to :back
  end

  def unpublish
    @post = BlogPost.find params[:id]
    head(401) and return unless can?(current_person, :update_blog_post, @post)
    @post.unpublish
    redirect_to :back
  end

  def manage
    @posts = BlogPost.all
  end

  protected
  def add_abilities
    abilities << BlogPost
  end

  private
  def post_params
    params.require(:blog_post).permit(:title, :body, :status)
  end

  def set_layout
    the_layout = 'application'
    the_layout = 'admin_panel' if ['index', 'new', 'edit'].include? action_name
    the_layout = 'blog' if action_name == 'show'
    the_layout
  end
end
