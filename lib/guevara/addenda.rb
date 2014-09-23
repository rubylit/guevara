module Guevara
  class Addenda

    attr_reader :attributes

    def initialize attributes
      @attributes = attributes
    end

    def to_s
      format ["7",                         # row type
              "05",                        # addenda type
              "%<additional_info>-80.80s",
              "%<index>04d",
              "%<entry_number>07d",
              "\n"].join, attributes
    end

  end
end
