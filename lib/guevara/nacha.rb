require_relative 'file_header'
require_relative 'file_control'
require_relative 'batch'

module Guevara
  class Nacha

    attr_reader :attributes, :batches

    def initialize attributes
      self.batches = attributes.delete(:batches)
      @attributes = attributes
    end

    def batches= batches
      @batches = batches.each_with_index.map do |batch_attributes, index|
        batch_attributes[:number] = index + 1
        Batch.new(batch_attributes)
      end
    end

    def to_s
      file = []
      file << file_header.to_s
      batches.each { |batch| file << batch.to_s }
      file << file_control.to_s
      file.join('')
    end

    def file_header
      FileHeader.new attributes
    end

    def total
      batches.
        map { |b| yield b }.
        reduce(:+)
    end

    def file_control
      entry_count = total { |b| b.batch_control.attributes[:entry_count] }
      total_count = entry_count + batches.size * 2 + 2
      block_count = (total_count/10.0).ceil # Count of the number of blocks of 10 rows within the file. https://achdevguide.nacha.org/ach-file-details

      FileControl.new(
        batch_count:  batches.count,
        block_count:  block_count,
        entry_count:  entry_count,
        entry_hash:   total { |b| b.batch_control.attributes[:entry_hash] },
        total_debit:  total { |b| b.total('debit') },
        total_credit: total { |b| b.total('credit') }
    )
    end
  end

end
