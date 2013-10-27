class ForumCategoriesController < ApplicationController
  include Authorizer

  respond_to :html

  layout 'admin_panel'

  before_filter :authenticate_person!
  before_filter :add_abilities

  def index
    @forum_categories = ForumCategory.all
    respond_with @forum_categories
  end

  def new
    @forum_category = ForumCategory.new
    head(401) and return unless can?(current_person, :create_forum_category, @forum_category)
    respond_with @forum_category
  end

  def create
    @forum_category = ForumCategory.new forum_params
    head(401) and return unless can?(current_person, :create_forum_category, @forum_category)
    flash[:notice] = 'Forum Category was saved successfully!' if @forum_category.save
    respond_with @forum_category
  end

  def edit
    @forum_category = ForumCategory.find params[:id]
    head(401) and return unless can?(current_person, :update_forum_category, @forum_category)
    respond_with @forum_category
  end

  def update
    @forum_category = ForumCategory.find params[:id]
    head(401) and return unless can?(current_person, :update_forum_category, @forum_category)
    if @forum_category.update_attributes forum_params
      flash[:notice] = 'Forum Category was updated successfully!'
    end
    respond_with @forum_category
  end

  def show
    @forum_category = ForumCategory.find params[:id]
    head(401) and return unless can?(current_person, :view_forum_category, @forum_category)
    respond_with @forum_category
  end
  
  def destroy
    @forum_category = ForumCategory.find params[:id]
    head(401) and return unless can?(current_person, :destroy_forum_category, @forum_category)
    @forum_category.delete
    respond_with @forum_category
  end

  protected
  def add_abilities
    abilities << ForumCategory
  end

  private
  def forum_category_params
    params.require(:forum_category).permit(:title, :description)
  end
end
