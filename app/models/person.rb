class Person < ActiveRecord::Base
  include Authorizable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :blog_posts
  has_many :role_assignments
  has_many :roles, through: :role_assignments

  has_one :profile

  accepts_nested_attributes_for :roles
  accepts_nested_attributes_for :profile

  validates :email, presence: true
  validates_inclusion_of :time_zone, in: ActiveSupport::TimeZone.zones_map(&:name)

  def has_role?(role_title)
    roles.select { |r| r.title == role_title.to_s }.any?
  end

  def administrator?
    has_role? :administrator
  end

  def self.allowed(person, target_person)
    rules = []
    return rules unless person.instance_of? Person
    return rules unless target_person.instance_of? Person
    rules << all_authorizations if person.has_role? :administrator
    rules.uniq
  end
end
