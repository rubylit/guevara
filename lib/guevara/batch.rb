require 'date'

module Guevara
  class Batch

    ACCOUNT_TYPE_CODE     = { 'checking' => '2', 'saving' => '3' }
    TRANSACTION_TYPE_CODE = { 'credit' => '2', 'debit' => '7' }

    attr_reader :options, :transactions

    def initialize(transactions, options)
      @transactions            = transactions
      @options                 = { discretionary_data: nil }.merge(options)
      @options[:date]           = Date.parse(options[:date]).strftime("%y%m%d")
      @options[:effective_date] = effective_date.strftime("%y%m%d")
    end

    def to_s
      batch = [ batch_header ]
      transactions.each_with_index do |transaction, index|
        batch << entry_detail(transaction, index)
      end
      batch.join("\n")
    end

    def batch_header
      format ["5",
              "%<service_class>3d",
              "%<company_name>-16.16s",
              "%<discretionary_data>-20.20s",
              "%<company_id>10.10s",
              "PPD          ",
              "%<date>s%<effective_date>s",
              "   1",
              "%<routing_number>8d",
              "%<index>07d"].join, options
    end

    def entry_detail transaction, index
      transaction_code =
        ACCOUNT_TYPE_CODE[transaction[:account_type]] +
        TRANSACTION_TYPE_CODE[transaction[:type]]
      format "6%2d%9d%-17.17s%010d%-15.15s%-22.22s  1%8d%07d",
        transaction_code,
        transaction[:routing_number],
        transaction[:account_number],
        transaction[:amount],
        transaction[:id],
        "#{ transaction[:first_name] } #{ transaction[:last_name] }",
        options[:routing_number],
        index + 1
    end

    def effective_date
      Date.parse transactions.first[:effective_date]
    end

  end
end
