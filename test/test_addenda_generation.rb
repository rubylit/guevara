require_relative 'helper.rb'
require_relative '../lib/guevara/addenda'

test 'generates an addenda record' do
  addenda = Guevara::Addenda.new({
    additional_info: "wellsville|KS|66092|101 2nd st|",
    index:           1,
    entry_number:    1
  }).to_s
  debugger_equal addenda, <<NACHA
705wellsville|KS|66092|101 2nd st|                                                 00010000001
NACHA
end
