class ForumCategoriesListOverview 
  include Enumerable

  attr_accessor :forum_categories

  def initialize(categories)
    self.forum_categories = categories
  end

  def to_partial_path
    'forum_categories/list_overview'
  end

  delegate :each, to: :forum_categories
end
