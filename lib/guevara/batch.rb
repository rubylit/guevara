require 'date'

module Guevara
  class Batch

    ACCOUNT_TYPE_CODE     = { 'checking' => '2', 'saving' => '3' }
    TRANSACTION_TYPE_CODE = { 'credit' => '2', 'debit' => '7' }

    attr_reader :service_class, :options, :transactions

    def initialize(transactions, options)
      @service_class  = 200
      @options        = options
      @transactions   = transactions
    end

    def to_s
      batch = [ batch_header ]
      transactions.each_with_index do |transaction, index|
        batch << entry_detail(transaction, index)
      end
      batch.join("\n")
    end

    def batch_header
      format "5%3d%-16.16s%-20.20s%10.10sPPD          %s%s   1%8d%07d",
        service_class,
        options[:company_name],
        '', # company discretionary data
        options[:company_id],
        Date.parse(options[:date]).strftime("%y%m%d"),
        effective_date.strftime("%y%m%d"),
        options[:routing_number],
        options[:index]
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
