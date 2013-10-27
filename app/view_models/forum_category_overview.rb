class ForumCategoryOverview < UI::Element

  attr_accessor :title, :description

  def initialize(forum_category)
    @category = forum_category
    super(forum_category.attributes)
  end

  def forum_category
    @category
  end

  def to_partial_path
    'forum_categories/forum_category_overview'
  end

  delegate :forums, to: :forum_category
end
