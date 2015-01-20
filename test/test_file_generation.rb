require_relative 'helper.rb'
require 'guevara'

setup do
  sample_nacha.merge(:batches => [sample_batch, sample_batch])
end

test 'generates nacha sample file' do
  expected = <<NACHA
101  12345678  123456781411281330A094101                Rubylit                   Zest       0
5200rubylit                                Ruby123PPD  payments140918140921   1123456780000001
6271031001953ACCOUNT234      0000001600FD00AFA8A0F7   marge baker             1123456780000001
705wellsville|KS|66092|101 2nd st|                                                 00010000001
82000000020010310019000000001600000000000000   Ruby123                         123456780000001
9000001000006000000020010310019000000001600000000000000                                       
NACHA
  nacha = Guevara::Nacha.new sample_nacha

  nacha.to_s.lines.to_a.each_with_index do |line, index|
    debugger_equal line, expected.lines.to_a[index]
  end
end

test 'file control row gets the number of batches' do |attributes|
  nacha = Guevara::Nacha.new attributes
  assert_equal lines(nacha).last[1,6].to_i, 2
end

test 'file control has the entry_hash' do |attributes|
  nacha = Guevara::Nacha.new attributes
  assert_equal lines(nacha).last[23,10].to_i, 2062003800
end

test 'file control has the total_debit' do |attributes|
  nacha = Guevara::Nacha.new attributes
  assert_equal lines(nacha).last[33,12].to_i, 320000
end

test 'file control has the total_credit' do |attributes|
  nacha = Guevara::Nacha.new attributes
  assert_equal lines(nacha).last[45,12].to_i, 0
end

test 'all the batches are added to the file' do
  batches = 5.times.map do
    sample_batch
  end
  nacha_attributes = sample_nacha.merge(:batches => batches)

  nacha = Guevara::Nacha.new nacha_attributes
  assert lines(nacha).size > 10
end
