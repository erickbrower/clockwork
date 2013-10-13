class BlogPost < ActiveRecord::Base

  belongs_to :author, class_name: 'Person'

  validates :title, presence: true

  scope :by_published, -> { where(status: :published) }

  before_save :markdown

  def markdown
    self.body = Kramdown::Document.new(self.body).to_html
  end
end
