module Guevara
  class Row

    attr_reader :attributes

    def initialize attributes
      self.attributes = attributes
      format_attributes
    end

    def attributes= attr
      @attributes = default_attributes.merge(attr)
    end

    def format_attributes
    end

    def default_attributes
      {}
    end

    def to_s
      format(fields.join, attributes) << "\n"
    end

  end
end
