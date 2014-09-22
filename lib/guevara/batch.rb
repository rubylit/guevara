require_relative 'entry'
require 'date'

module Guevara
  class Batch

    ACCOUNT_TYPE_CODE     = { 'checking' => '2', 'saving' => '3' }
    TRANSACTION_TYPE_CODE = { 'credit' => '2', 'debit' => '7' }

    attr_reader :attributes, :transactions

    def initialize(transactions, attributes)
      @transactions = transactions
      self.attributes  = attributes
    end

    def attributes= attributes
      default_attributes = {
        discretionary_data: nil,
        effective_date:     effective_date.strftime("%y%m%d")
      }
      @attributes = default_attributes.merge(attributes)
      @attributes[:date] = Date.parse(attributes[:date]).strftime("%y%m%d")
    end

    def to_s
      batch = [ batch_header ]
      entries.each do |entry|
        batch << entry.to_s
      end
      batch << batch_control
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
              "\n"].join, attributes
    end

    def batch_control
      attributes[:entry_addenda_count] = entries.size
      attributes[:entry_hash]          = entry_hash
      attributes[:total_debit]         = total('debit')
      attributes[:total_credit]        = total('credit')
      format ["8",
              "%<service_class>3d",
              "%<entry_addenda_count>06d",
              "%<entry_hash>010d",
              "%<total_debit>012d",
              "%<total_credit>012d",
              "%<company_id>10.10s",
              " " * 25,
              "%<routing_number>8d",
              "%<index>07d",
              "\n"].join, attributes
    end

    def entry_hash
      entries.
        map{ |e| e.to_s }.
        select{ |e| e[0] == '6' }. # only use entry detail rows
        map{ |e| e[3..10].to_i }.  # take only 4-11 places
        reduce(:+).                # sum
        modulo(10_000_000_000)     # cap to 10 digits
    end

    def total type
      transactions.
        select{ |t| t[:type] == type }.
        map{ |t| t[:amount] }.
        reduce(0, :+).
        modulo(1_000_000_000_000)
    end

    def effective_date
      Date.parse transactions.first[:effective_date]
    end

    def entries
      @entries ||= transactions.each_with_index.map do |transaction, index|
        t = transaction.merge index: index + 1,
                              signature_routing_number: attributes[:routing_number]
        Entry.new t
      end
    end

  end
end
