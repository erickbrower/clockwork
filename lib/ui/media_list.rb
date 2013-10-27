module UI
  class MediaList < Element
    attr_accessor :items

    def initialize(args={})
      self.items = []
      super(args)
    end

    def to_partial_path
      'shared/ui/media_list'
    end
  end
end
