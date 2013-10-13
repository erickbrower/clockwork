class BlogPost < ActiveRecord::Base

  belongs_to :author, class_name: 'Person'

  validates :title, presence: true

  scope :by_published, -> { where(status: :published) }

  before_save :pre_process

  def pre_process
    self.body = Sanitize.clean(self.body)
    self.body = Kramdown::Document.new(self.body).to_html
    self.status = :draft
  end

  def self.authorizations
    [:view, :create, :update, :destroy].collect { |a| "#{a}_blog_post".to_sym }
  end

  def self.allowed(person, blog_post)
    rules = []
    rules << :view_blog_post
    return rules unless person.instance_of? Person
    return rules unless blog_post.instance_of? BlogPost
    rules << authorizations  if person.has_role? :administrator
    rules << :create_blog_post if person.has_role? :blog_author
    if blog_post.author
      rules << :edit_blog_post if blog_post.author.id == person.id
      rules << :destroy_blog_post if blog_post.author.id == person.id
    end
    rules
  end
end
