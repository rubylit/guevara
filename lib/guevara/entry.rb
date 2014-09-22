module Guevara
  class Entry

    ACCOUNT_TYPE_CODE     = { 'checking' => '2', 'saving' => '3' }
    TRANSACTION_TYPE_CODE = { 'credit' => '2', 'debit' => '7' }

    attr_reader :transaction

    def initialize transaction
      @transaction = transaction
      @transaction[:transaction_code] ||= transaction_code
      @transaction[:full_name]        ||= "#{ transaction[:first_name] } #{ transaction[:last_name]}"
    end

    def to_s
      entry_detail
    end

    def entry_detail
      format ["6%<transaction_code>2d",
              "%<routing_number>9d",
              "%<account_number>-17.17s",
              "%<amount>010d",
              "%<id>-15.15s",
              "%<full_name>-22.22s",
              "  1%<signature_routing_number>8d",
              "%<index>07d",
              "\n"].join, transaction
    end

    def transaction_code
      ACCOUNT_TYPE_CODE[transaction[:account_type]] +
        TRANSACTION_TYPE_CODE[transaction[:type]]
    end

  end
end
