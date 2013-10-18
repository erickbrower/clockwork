class BlogPost < ActiveRecord::Base
  include Authorizable

  belongs_to :author, foreign_key: 'person_id', class_name: 'Person'

  validates :title, presence: true

  scope :by_published, -> { where(status: :published) }

  before_create :process_draft

  before_save :process_body

  def published?
    status.to_sym == :published
  end

  def process_draft
    process_body
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
    rules.uniq
  end
  
  private
  def process_body
    if body_changed?
      self.body_html = Maruku.new(self.body).to_html
      self.body_html = Sanitize.clean(self.body_html, Sanitize::Config::RELAXED)
      self.body = Sanitize.clean(self.body, Sanitize::Config::RELAXED)
    end
  end

end
