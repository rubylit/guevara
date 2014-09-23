require 'date'

module Guevara
  class FileHeader

    attr_reader :attributes

    def initialize attributes
      self.attributes = attributes
      format_attributes
    end

    def default_attributes
      { reference: 0 }
    end

    def attributes= attr
      @attributes = default_attributes.merge(attr)
    end

    def format_attributes
      attributes[:created_at] = DateTime.parse(attributes[:created_at]).
        strftime('%y%m%d%H%M')
    end

    def fields
      ["1",
       "%<priority_code>02d",
       "%<destination_id>010d",
       "%<origin_id>010d",
       "%<created_at>10.10s",
       "%<id>1.1s",
       "094", # record size is fixed
       "10",  # blocking factor
       "1",   # format code
       "%<destination_name>23.23s",
       "%<origin_name>23.23s",
       "%<reference>8d"]
    end

    def to_s
      format(fields.join, attributes) << "\n"
    end

  end
end
