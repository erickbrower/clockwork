class Person < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :blog_posts
  has_many :role_assignments
  has_many :roles, through: :role_assignments

  def has_role?(role_titles)
    self.roles.where(title: role_titles).any?
  end

  def self.all_rules
    [:view, :create, :update, :destroy].collect { |a| "#{a}_person".to_sym }
  end

  def self.allowed(person, subject_person)
    rules = []
    return rules unless person.instance_of? Person
    return rules unless subject_person.instance_of? Person
    rules. << all_rules if person.has_role? :administrator
    rules
  end

end
