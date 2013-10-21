class ForumThreadsController < ApplicationController
  respond_to :html
  layout :set_layout

  def index
    @forum_threads = ForumThread.all
    respond_with @forum_threads
  end

  def new
    @forum_thread = ForumThread.new
    @forum_thread.forum_posts.build
  end

  def create
    @forum_thread = ForumThread.new forum_thread_params
    @forum_thread.original_poster = current_person
    @forum_thread.forum_posts.first.author = current_person
    flash[:notice] = 'Thread created successfully!' if @forum_thread.save
    respond_with @forum_thread
  end

  def show
    @forum_thread = ForumThread.find params[:id]
    respond_with @forum_thread
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def forum_thread_params
    params.require(:forum_thread).permit(:title, forum_posts_attributes: [:body, :tldr])
  end
  
  def set_layout
    case action_name
    when 'show' then 'forum'
    else 'application'
    end
  end
end
