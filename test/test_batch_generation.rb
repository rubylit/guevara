require_relative 'helper.rb'
require_relative '../lib/guevara/batch'

setup do
  sample_batch.merge(:number => 1)
end

test 'generates the batch' do |attributes|
  batch = Guevara::Batch.new attributes
  expected = <<NACHA
5200rubylit                                Ruby123PPD7166666666140918140921   1123456780000001
6271031001953ACCOUNT234      0000001600FD00AFA8A0F7   marge baker             1123456780000001
705wellsville|KS|66092|101 2nd st|                                                 00010000001
82000000020010310019000000001600000000000000   Ruby123                         123456780000001
NACHA
  batch.to_s.lines.to_a.each_with_index do |line, index|
    debugger_equal line, expected.lines.to_a[index]
  end
end

test 'discretionary data is added to the batch header' do |attributes|
  batch = Guevara::Batch.new attributes.merge(
    discretionary_data: 'something custom')
  expected = <<NACHA
5200rubylit         something custom       Ruby123PPD7166666666140918140921   1123456780000001
6271031001953ACCOUNT234      0000001600FD00AFA8A0F7   marge baker             1123456780000001
705wellsville|KS|66092|101 2nd st|                                                 00010000001
82000000020010310019000000001600000000000000   Ruby123                         123456780000001
NACHA
  batch.to_s.lines.to_a.each_with_index do |line, index|
    debugger_equal line, expected.lines.to_a[index]
  end
end
