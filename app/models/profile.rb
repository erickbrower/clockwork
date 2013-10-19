class Profile < ActiveRecord::Base
  include Authorizable

  belongs_to :owner, foreign_key: 'person_id', class_name: 'Person'

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :birthdate, presence: true

  def self.allowed(person, profile)
    rules = []
    return rules unless person.instance_of? Person
    return rules unless profile.instance_of? Profile
    rules += all_authorizations if person.has_role? :administrator
    if profile.owner.id == person.id
      rules += [:create_profile , :update_profile, :destroy_profile]
    end
    rules << :view_profile
    rules.uniq
  end
end
