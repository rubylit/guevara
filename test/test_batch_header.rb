require_relative 'helper.rb'
require_relative '../lib/guevara/batch_header'

setup do
  sample_batch.merge(number: 1)
end

test 'generates the batch header' do |attributes|
  batch_header = Guevara::BatchHeader.new attributes

  debugger_equal batch_header.to_s, <<NACHA
5200rubylit                                Ruby123PPD7166666666140918140921   1123456780000001
NACHA
end

test 'discretionary data can be added' do |attributes|
  batch_header = Guevara::BatchHeader.new attributes.merge(
    discretionary_data: 'something here')

  debugger_equal batch_header.to_s, <<NACHA
5200rubylit         something here         Ruby123PPD7166666666140918140921   1123456780000001
NACHA
end
