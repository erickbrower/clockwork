class Forum < ActiveRecord::Base
  include Authorizable

  has_many :forum_threads
  belongs_to :forum_category

  validates :title, presence: true

  def self.allowed(person, forum)
    rules = []
    return rules unless person.instance_of? Person
    return rules unless forum.instance_of? Forum
    rules += all_authorizations if person.has_role? :administrator
    rules.uniq
  end
end
