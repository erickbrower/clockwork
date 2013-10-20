class BlogPost < ActiveRecord::Base
  include Authorizable

  belongs_to :author, foreign_key: 'person_id', class_name: 'Person'
  has_many :comments, as: :commentable

  validates :title, presence: true

  scope :by_published, -> { where(status: :published) }

  before_create :process_draft

  before_save :process_body

  acts_as_taggable

  STATUSES = [:published, :draft, :raw]

  def published?
    return false if status.nil?
    status.to_sym == :published
  end

  def process_draft
    process_body
    self.status = :draft
  end

  def publish
    update_attribute :status, :published
  end
  def unpublish
    update_attribute :status, :draft
  end

  def authored_by?(person)
    author.id == person.id
  end

  def self.allowed(person, blog_post)
    rules = []
    return rules unless person.instance_of? Person
    return rules unless blog_post.instance_of? BlogPost
    rules += all_authorizations  if person.has_role? :administrator
    rules << :create_blog_post if person.has_role? :blog_author
    if blog_post.author && blog_post.authored_by?(person)
      rules += [:update_blog_post, :destroy_blog_post] 
    end
    rules << :view_blog_post
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
