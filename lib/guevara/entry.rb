require_relative 'row'

module Guevara
  class Entry < Row

    ACCOUNT_TYPE_CODE     = { 'checking' => '2', 'saving' => '3' }
    TRANSACTION_TYPE_CODE = { 'credit' => '2', 'debit' => '7' }

    def format_attributes
      attributes[:transaction_code] ||= transaction_code
    end

    def fields
      ["6%<transaction_code>2d",
       "%<routing_number>09d",
       "%<account_number>-17.17s",
       "%<amount>010d",
       "%<id>-15.15s",
       "%<name>-22.22s",
       "  1",  # Addenda record indicator
       "%<origin_id>8d",
       "%<number>07d"]
    end

    def transaction_code
      ACCOUNT_TYPE_CODE[attributes[:account_type]] +
        TRANSACTION_TYPE_CODE[attributes[:type]]
    end

  end
end
