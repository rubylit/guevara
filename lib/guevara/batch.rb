require_relative 'batch_header'
require_relative 'batch_control'
require_relative 'addenda'
require_relative 'entry'
require 'date'

module Guevara
  class Batch

    attr_reader :transactions, :attributes

    def initialize(transactions, attributes)
      @transactions = transactions
      @attributes   = attributes
    end

    def to_s
      batch = []
      batch << batch_header.to_s
      transactions.each_with_index do |transaction, index|
        batch << entry(transaction, index).to_s
        batch << addenda(transaction, index).to_s
      end
      batch << batch_control
      batch.join
    end

    def batch_header
      header_attributes = { effective_date: effective_date }.merge(attributes)
      BatchHeader.new header_attributes
    end

    def batch_control
      control_attributes = {
        entry_count:    transactions.size * 2,
        entry_hash:     entry_hash,
        total_debit:    total('debit'),
        total_credit:   total('credit')
      }.merge(attributes)
      BatchControl.new control_attributes
    end

    def entry_hash
      transactions.
        map{ |t| t[:routing_number].to_i / 10 }. # ignore the check digit
        reduce(:+).                              # sum
        modulo(10_000_000_000)                   # cap to 10 digits
    end

    def total type
      transactions.
        select{ |t| t[:type] == type }.
        map{ |t| t[:amount] }.
        reduce(0, :+).
        modulo(1_000_000_000_000)
    end

    def effective_date
      transactions.first[:effective_date]
    end

    def entry transaction, index
      entry_attributes = transaction.merge(number: index + 1,
                                           origin_id: attributes[:origin_id])
      Entry.new entry_attributes
    end

    def addenda transaction, index
      Addenda.new transaction.merge(entry_number: index + 1)
    end

  end
end
