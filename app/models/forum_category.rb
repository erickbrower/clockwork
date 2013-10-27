class ForumCategory < ActiveRecord::Base
  include Authorizable

  has_many :forums

  def self.allowed(person, forum_category)
    rules = []
    return rules unless person.instance_of? Person
    return rules unless forum_category.instance_of? ForumCategory
    rules += all_authorizations if person.has_role? :administrator
    rules.uniq
  end

end
