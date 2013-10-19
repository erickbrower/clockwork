class PeopleController < ApplicationController
  respond_to :html

  layout 'admin_panel'

  def index
    @people = Person.all
    unless can?(current_person, :view_person, @people)
    end
    respond_with @people
  end

  def show
    @person = Person.find params[:id]
    respond_with @person
  end

  def new
    @person = Person.new
    @person.profile = Profile.new
  end

  def edit
    @person = Person.find params[:id]
    respond_with @person
  end

  def create
    @person = Person.new person_params
    if person_params[:profile_attributes] && person_params[:profile_attributes][:birthdate]
      begin
      @person.profile.birthdate = Date.strptime(person_params[:profile_attributes][:birthdate],
                                                "%m\/%d\/%Y")
      rescue ArgumentError
      end
    end
    flash[:notice] = 'Person was saved successfully!' if @person.save
    respond_with @person
  end

  def update
    @person = Person.find params[:id]
    if person_params[:profile_attributes] && person_params[:profile_attributes][:birthdate]
      begin
      @person.profile.birthdate = Date.strptime(person_params[:profile_attributes][:birthdate],
                                                "%m\/%d\/%Y")
      rescue ArgumentError
      end
    end
    if @person.update_attributes person_params
      flash[:notice] = 'Person was updated successfully!'
    end
    respond_with @person
  end

  def destroy
    @person = Person.find params[:id]
    @person.delete
    respond_with @person
  end

  private
  def person_params
    params.require(:person).permit(:email, :password, :password_confirmation, role_ids: [], 
                                   profile_attributes: [ :first_name, :last_name, :birthdate, :twitter_handle, :bio])
  end
end
