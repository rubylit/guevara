require_relative 'helper.rb'
require_relative '../lib/guevara/file_control'

test 'generates an file control' do
  file_control = Guevara::FileControl.new(
    batch_count:     2,
    block_count:     8,
    entry_count:     4,
    entry_hash:      12249928,
    total_debit:     12557,
    total_credit:    0,
  ).to_s
  debugger_equal file_control, <<NACHA
9000002000008000000040012249928000000012557000000000000                                       
NACHA
end


