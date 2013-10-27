module UI
  class NavListItem < Element
    attr_accessor :body, :active

    def initialize(args={})
      self.active = false
      super(args)
    end

    def active?
      self.active
    end

    def to_partial_path
      'shared/ui/nav_list_item'
    end
  end
end
