require_relative 'helper.rb'
require_relative '../lib/guevara/entry'

setup do
  Guevara::Entry.new(
    type:             'debit',
    account_type:     'checking',
    routing_number:   103100195,
    account_number:   '3ACCOUNT234',
    amount:           1600,
    id:               'FD00AFA8A0F7',
    name:             'marge baker',
    origin_id:        '12345678',
    number:           1
  )
end

test 'generates the entry detail record' do |entry_record|
  debugger_equal entry_record.to_s, <<NACHA
6271031001953ACCOUNT234      0000001600FD00AFA8A0F7   marge baker             1123456780000001
NACHA
end
