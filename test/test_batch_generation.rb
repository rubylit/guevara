require_relative 'helper.rb'
require_relative '../lib/guevara/batch'

def sample_options
  {
    :service_class  => '200',
    :routing_number => '12345678',
    :company_name   => 'rubylit',
    :company_id     => 'Ruby123',
    :date           => '2014-09-18',
    :index          => 1
  }
end

test 'generates the batch header' do
  batch = Guevara::Batch.new [ sample_transaction ], sample_options
  debugger_equal batch.to_s.lines.to_a.first, <<NACHA
5200rubylit                                Ruby123PPD          140918140921   1123456780000001
NACHA
end

test 'generates the entry detail record' do
  batch = Guevara::Batch.new [ sample_transaction ], sample_options
  entry_detail = batch.to_s.lines.to_a[1]
  expected =
"6271031001953ACCOUNT234      0000001600FD00AFA8A0F7   marge baker             1123456780000001"

  debugger_equal entry_detail, expected
end
