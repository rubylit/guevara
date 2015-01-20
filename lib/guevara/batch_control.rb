require_relative 'row'

module Guevara
  class BatchControl < Row

    def default_attributes
      { discretionary_data: '' }
    end

    def fields
      ["8",
       "%<service_class>3d",
       "%<entry_count>06d",
       "%<entry_hash>010d",
       "%<total_debit>012d",
       "%<total_credit>012d",
       "%<company_id>10.10s",
       " " * 25,  # Authentication and reserved fields.
       "%<origin_id>8s",
       "%<number>07d"]
    end

  end
end
