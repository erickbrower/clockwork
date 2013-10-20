class ForumThread < ActiveRecord::Base
  has_many :forum_posts
  belongs_to :forum_category

  acts_as_taggable
end
