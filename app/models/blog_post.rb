class BlogPost < ActiveRecord::Base
  include Authorizable

  belongs_to :author, foreign_key: 'person_id', class_name: 'Person'

  validates :title, presence: true

  scope :by_published, -> { where(status: :published) }

  before_save :process_draft

  def published?
    status.to_sym == :published
  end

  def process_draft
    self.body_html = Maruku.new(self.body).to_html
    self.body = Sanitize.clean(self.body, Sanitize::Config::RELAXED)
    self.status = :draft
  end

  def publish
    update_attribute :status, :published
  end

  def self.allowed(person, blog_post)
    rules = []
    return rules unless person.instance_of? Person
    return rules unless blog_post.instance_of? BlogPost
    rules += all_authorizations  if person.has_role? :administrator
    rules << :create_blog_post if person.has_role? :blog_author
    if blog_post.author
      rules << :update_blog_post if blog_post.author.id == person.id
      rules << :destroy_blog_post if blog_post.author.id == person.id
    end
    rules << :view_blog_post unless rules.include? :view_blog_post 
    rules
  end
end
