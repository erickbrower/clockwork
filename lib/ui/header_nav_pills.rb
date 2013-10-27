module UI
  class HeaderNavPills < HeaderNav
    attr_accessor :items

    def initialize(args={})
      self.items = []
      super(args)
    end

    def to_partial_path
      'shared/ui/header_nav_pills'
    end
  end
end
