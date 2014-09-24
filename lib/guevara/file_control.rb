require 'date'
require_relative 'row'

module Guevara
  class FileControl < Row

    def fields
      ["9",
       "%<batch_count>06d",
       "%<block_count>06d",
       "%<entry_count>08d",
       "%<entry_hash>010d",
       "%<total_debit>012d",
       "%<total_credit>012d",
       " " * 39] # reserved
    end

  end
end
