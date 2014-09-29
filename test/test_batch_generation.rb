require_relative 'helper.rb'
require_relative '../lib/guevara/batch'

setup do
  Guevara::Batch.new sample_batch.merge(:number => 1)
end

test 'generates the batch' do |batch|
  expected = <<NACHA
5200rubylit                                Ruby123PPD          140918140921   1123456780000001
6271031001953ACCOUNT234      0000001600FD00AFA8A0F7   marge baker             1123456780000001
705wellsville|KS|66092|101 2nd st|                                                 00010000001
82000000020010310019000000001600000000000000   Ruby123                         123456780000001
NACHA
  batch.to_s.lines.to_a.each_with_index do |line, index|
    debugger_equal line, expected.lines.to_a[index]
  end
end
