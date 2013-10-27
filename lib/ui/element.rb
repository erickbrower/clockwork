module UI
  class Element
    attr_accessor :wrapper_classes

    def initialize(args={})
      self.wrapper_classes = []
      args.each_pair do |k, v|
        send("#{k}=", v) if respond_to?("#{k}=")
      end
    end

    def wrapper_class
      self.wrapper_classes.join(' ')
    end
  end
end
