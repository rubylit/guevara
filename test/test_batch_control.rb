require_relative 'helper.rb'
require_relative '../lib/guevara/batch_control'

setup do
  Guevara::BatchControl.new(
    service_class:  '200',
    entry_count:    2,
    entry_hash:     10310019,
    total_debit:    1200,
    total_credit:   3500,
    company_id:     'Ruby123',
    origin_id:      '12345678',
    number:         1
  )
end

test 'generates the batch contol row' do |batch_control|
  debugger_equal batch_control.to_s, <<NACHA
82000000020010310019000000001200000000003500   Ruby123                         123456780000001
NACHA
end
