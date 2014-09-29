require_relative 'helper.rb'
require 'guevara'

test 'generates nacha sample file' do |batch|
  expected = <<NACHA
101001234567800123456781411281330A094101                Rubylit                   Zest       0
5200rubylit                                Ruby123PPD          140918140921   1123456780000001
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

test 'file control row gets the number of batches' do
  nacha_attributes = sample_nacha.merge(:batches => [sample_batch, sample_batch])
  nacha = Guevara::Nacha.new nacha_attributes

  assert_equal lines(nacha).last[1,6].to_i, 2
end
