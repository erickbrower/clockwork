module API
  module V1
    class BlogPostsController < ApplicationController
      respond_to :json, :xml

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
    end
  end
end
