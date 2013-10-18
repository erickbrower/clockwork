module PeopleHelper
  def edit_button(person)
    link_to "<span class='glyphicon glyphicon-pencil'></span>".html_safe, 
            edit_person_path(person), 
            class: 'btn btn-sm btn-primary'
  end

  def delete_button(person)
    link_to "<span class='glyphicon glyphicon-remove'></span>".html_safe, 
            person_path(person), 
            method: :delete, 
            class: 'btn btn-sm btn-danger'

  end

end
