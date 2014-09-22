require_relative 'entry'
require 'date'

module Guevara
  class Batch

    ACCOUNT_TYPE_CODE     = { 'checking' => '2', 'saving' => '3' }
    TRANSACTION_TYPE_CODE = { 'credit' => '2', 'debit' => '7' }

    attr_reader :options, :transactions

    def initialize(transactions, options)
      @transactions = transactions
      self.options  = options
    end

    def options= options
      default_options = {
        discretionary_data: nil,
        effective_date:     effective_date.strftime("%y%m%d")
      }
      @options = default_options.merge(options)
      @options[:date] = Date.parse(options[:date]).strftime("%y%m%d")
    end

    def to_s
      batch = [ batch_header ]
      entries.each do |entry|
        batch << entry.to_s
      end
      batch.join
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
              "%<index>07d",
              "\n"].join, options
    end

    def effective_date
      Date.parse transactions.first[:effective_date]
    end

    def entries
      @entries ||= transactions.each_with_index.map do |transaction, index|
        t = transaction.merge index: index + 1,
                              signature_routing_number: options[:routing_number]
        Entry.new t
      end
    end

  end
end
