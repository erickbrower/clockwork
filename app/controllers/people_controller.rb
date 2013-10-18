class PeopleController < ApplicationController
  respond_to :html

  layout :set_layout

  def index
    @people = Person.all
    respond_with @people
  end

  def show
  end

  def new
    @person = Person.new
  end

  def edit
    @person = Person.find params[:id]
    respond_with @person
  end

  def create
    @person = Person.new person_params
    flash[:notice] = 'Person was saved successfully!' if @person.save
    respond_with @person
  end

  def update
    @person = Person.find params[:id]
    if @person.update_attributes person_params
      flash[:notice] = 'Person was updated successfully!'
    end
    respond_with @person
  end

  def destroy
  end

  private
  def set_layout
    the_layout = 'admin_panel'
    the_layout
  end

  def person_params
    params.require(:person).permit(:email, :password, :password_confirmation, :role_ids)
  end
end
