module UI
  class MediaListItem < Element
    attr_accessor :image_link, :image_src, :image_alt, :heading, :body

    def to_partial_path
      'shared/ui/media_list_item'
    end

  end
end
