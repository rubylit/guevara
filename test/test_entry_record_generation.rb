require_relative 'helper.rb'
require_relative '../lib/guevara/entry'

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

test 'generates the entry detail record' do
  transaction = sample_transaction.merge(signature_routing_number: sample_options[:routing_number], index: 1)
  entry_record = Guevara::Entry.new transaction
  expected =
"6271031001953ACCOUNT234      0000001600FD00AFA8A0F7   marge baker             1123456780000001"

  debugger_equal entry_record.to_s, expected
end
