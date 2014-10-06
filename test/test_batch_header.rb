require_relative 'helper.rb'
require_relative '../lib/guevara/batch_header'

setup do
  {
    service_class:  '200',
    company_name:   'rubylit',
    company_id:     '7654321',
    company_date:   '2014-09-18',
    effective_date: '2014-09-21',
    origin_id:      '12345678',
    number:         1,
    company_entry_description: '7166666666'
  }
end

test 'generates the batch header' do |attributes|
  batch_header = Guevara::BatchHeader.new attributes

  debugger_equal batch_header.to_s, <<NACHA
5200rubylit                                7654321PPD7166666666140918140921   1123456780000001
NACHA
end

test 'discretionary data can be added' do |attributes|
  batch_header = Guevara::BatchHeader.new attributes.merge(
    discretionary_data: 'something here')

  debugger_equal batch_header.to_s, <<NACHA
5200rubylit         something here         7654321PPD7166666666140918140921   1123456780000001
NACHA
end
