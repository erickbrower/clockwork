class Person < ActiveRecord::Base
  include Authorizable

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :blog_posts
  has_many :role_assignments
  has_many :roles, through: :role_assignments

  def has_role?(role_title)
    roles.select { |r| r.title == role_title.to_s }.any?
  end

  def self.allowed(subject_person, person)
    rules = []
    return rules unless person.instance_of? Person
    return rules unless subject_person.instance_of? Person
    rules << all_authorizations if person.has_role? :administrator
    rules
  end

end
