class ForumPost < ActiveRecord::Base
  belongs_to :forum_thread
  belongs_to :author, foreign_key: 'person_id', class_name: 'Person'

  default_scope { order('created_at DESC') }

end
