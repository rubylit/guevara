require_relative 'row'

module Guevara
  class Addenda < Row

    def default_attributes
      {
        number: 1 # we should not have more than 1 addenda
      }
    end

    def fields
      ["7",                         # row type
       "05",                        # addenda type
       "%<additional_info>-80.80s",
       "%<number>04d",
       "%<entry_number>07d"]
    end

  end
end
