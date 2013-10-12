class BlogPostsController < ApplicationController
  respond_to :html, :json, :xml

  before_filter :authenticate_person!, except: [:index, :show]

  def index
    @posts = BlogPost.all
    respond_with @posts
  end

  def new
    @post = BlogPost.new
    respond_with @post
  end

  def create
    @post = BlogPost.new post_params
    flash[:notice] = 'Blog Post was saved successfully!' if @post.save
    respond_with @post
  end

  def edit
    @post = BlogPost.find params[:id]
    respond_with @post
  end

  def update
    @post = BlogPost.find params[:id]
    if @post.update_attributes post_params
      flash[:notice] = 'Blog Post was updated successfully!'
    end
    respond_with @post
  end

  def show
    @post = BlogPost.find params[:id]
    respond_with @post
  end

  private
  def post_params
    params.require(:blog_post).permit(:title, :body, :status)
  end
end
