class ForumPost < ActiveRecord::Base
  belongs_to :forum_thread
  delegate :forum_category, to: :forum_thread

end
