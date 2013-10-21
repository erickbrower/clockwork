module PeopleHelper
  def person_new_button
    link_to '<span class="glyphicon glyphicon-plus"></span> New Person'.html_safe, new_person_path
  end

  def person_edit_button_for(person)
    link_to "<span class='glyphicon glyphicon-pencil'></span>".html_safe, 
            edit_person_path(person), 
            class: 'btn btn-sm btn-primary'
  end

  def person_delete_button_for(person)
    link_to "<span class='glyphicon glyphicon-remove'></span>".html_safe, 
            person_path(person), 
            method: :delete, 
            class: 'btn btn-sm btn-danger'

  end

  def person_admin_grid_for(people)
    render partial: 'people/admin_grid', locals: { people: people } 
  end

  def gravatar_for(person, options = { size: 100 })
    size = options[:size]
    gravatar_id = Digest::MD5::hexdigest(person.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}.png?s=#{size}"
    if options[:url]
      img = image_tag(gravatar_url, alt: person.email, class: "thumbnail")
      return link_to "#{img}".html_safe, url
    end
    image_tag(gravatar_url, alt: person.email, class: "thumbnail img-responsive")
  end
end
