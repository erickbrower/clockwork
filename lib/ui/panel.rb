module UI
  class Panel < Element
    attr_accessor :heading, :body, :footer

    def to_partial_path
      'shared/ui/panel'
    end
  end
end
