class CommentsController < ApplicationController
  respond_to :html

  before_filter :load_commentable

  def index
    @comments = @commentable.comments
  end

  def new
    @comment = @commentable.comments.new
  end

  def create
    @comment = @commentable.comments.new comment_params
    if @comment.save
      flash[:notice] = 'Added comment successfully!'
    else
      flash[:error] = 'There was a problem saving your comment :('
    end
    redirect_to :back
  end

  private
  def load_commentable
    klass = [BlogPost].detect { |c| c.to_s == comment_params[:commentable_type] }
    @commentable = klass.find(comment_params[:commentable_id])
  end

  def comment_params
    params.require(:comment).permit(:content, :commentable_id, :commentable_type)
  end
end
