require_relative 'helper.rb'
require_relative '../lib/guevara/batch_header'

setup do
  Guevara::BatchHeader.new(
    service_class:  '200',
    company_name:   'rubylit',
    company_id:     '7654321',
    company_date:   '2014-09-18',
    effective_date: '2014-09-21',
    origin_id:      '12345678',
    number:         1,
    discretionary_data: 'abcdefghijklmnopqrst',
    company_entry_description: '7166666666'
  )
end

test 'generates the batch header' do |batch_header|
  debugger_equal batch_header.to_s, <<NACHA
5200rubylit         abcdefghijklmnopqrst   7654321PPD7166666666140918140921   1123456780000001
NACHA
end
