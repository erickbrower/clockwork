class ForumsController < ApplicationController
  respond_to :html

  layout 'admin_panel'

  before_filter :authenticate_person!
  before_filter :add_abilities

  def index
    @forums = Forum.all
    respond_with @forums
  end

  def new
    @forum = Forum.new
    head(401) and return unless can?(current_person, :create_forum, @forum)
    respond_with @forum
  end

  def create
    @forum = Forum.new forum_params
    head(401) and return unless can?(current_person, :create_forum, @forum)
    flash[:notice] = 'Forum was saved successfully!' if @forum.save
    respond_with @forum
  end

  def edit
    @forum = Forum.find params[:id]
    head(401) and return unless can?(current_person, :update_forum, @forum)
    respond_with @forum
  end

  def update
    @forum = Forum.find params[:id]
    head(401) and return unless can?(current_person, :update_forum, @forum)
    if @forum.update_attributes forum_params
      flash[:notice] = 'Forum was updated successfully!'
    end
    respond_with @forum
  end

  def show
    @forum = Forum.find params[:id]
    head(401) and return unless can?(current_person, :view_forum, @forum)
    respond_with @forum
  end
  
  def destroy
    @forum = Forum.find params[:id]
    head(401) and return unless can?(current_person, :destroy_forum, @forum)
    @forum.delete
    respond_with @forum
  end

  protected
  def add_abilities
    abilities << Forum
  end

  private
  def forum_params
    params.require(:forum).permit(:title, :description)
  end
end
