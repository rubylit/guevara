require 'date'
require_relative 'row'

module Guevara
  class BatchHeader < Row

    def default_attributes
      {
        discretionary_data: ''
      }
    end

    def format_attributes
      attributes[:company_date] = Date.parse(attributes[:company_date]).
        strftime('%y%m%d')
      attributes[:effective_date] = Date.parse(attributes[:effective_date]).
        strftime('%y%m%d')
    end

    def fields
      ["5",
       "%<service_class>3d",
       "%<company_name>-16.16s",
       "%<discretionary_data>-20.20s",
       "%<company_id>10.10s",
       "PPD",
       "%<entry_description>10.10s",
       "%<company_date>s",
       "%<effective_date>s",
       "   1",
       "%<origin_id>8s",
       "%<number>07d"]
    end

  end
end
