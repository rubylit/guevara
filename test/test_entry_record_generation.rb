require_relative 'helper.rb'
require_relative '../lib/guevara/entry'

setup do
  transaction = sample_transaction.merge(signature_routing_number: '12345678', index: 1)
  Guevara::Entry.new transaction
end

test 'generates the entry detail record' do |entry_record|

  debugger_equal entry_record.to_s, <<NACHA
6271031001953ACCOUNT234      0000001600FD00AFA8A0F7   marge baker             1123456780000001
NACHA
end
