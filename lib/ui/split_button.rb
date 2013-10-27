module UI
  class SplitButton < Element
    attr_accessor :option, :text, :url, :icon, :dropdown_links

    def initialize(fields={})
      self.dropdown_links = []
      super(fields)
    end

    def to_partial_path
      'shared/ui/split_button'
    end
  end
end
