module UI
  class Panel < Element
    attr_accessor :heading, :body, :footer, :option

    def option_class
      "panel-#{option}"
    end

    def to_partial_path
      'shared/ui/panel'
    end
  end
end
