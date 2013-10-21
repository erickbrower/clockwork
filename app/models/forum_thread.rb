class ForumThread < ActiveRecord::Base
  belongs_to :forum_category
  belongs_to :original_poster, foreign_key: 'person_id', class_name: 'Person'

  has_many :forum_posts
  acts_as_taggable

  accepts_nested_attributes_for :forum_posts

  def original_post
    forum_posts.order('created_at DESC').first
  end


  alias_method :op, :original_poster
end
