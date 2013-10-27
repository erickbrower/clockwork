module UI
  class HeaderNav < Element
    attr_accessor :items, :option

    def initialize(args={})
      self.items = []
      self.option = :pills
      super(args)
    end

    def option_class
      "nav-#{self.option}"
    end

    def to_partial_path
      'shared/ui/header_nav'
    end
  end
end
