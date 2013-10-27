class ForumsListOverview
  include Enumerable

  attr_accessor :forums

  def initialize(forums, wrapper_klass=ForumOverview)
    forums.each do |f|
      self.forums << wrapper_klass.new(f)
    end
  end

  delegate :each, :forums
end
