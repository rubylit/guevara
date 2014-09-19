require_relative '../lib/guevara/batch'

def sample_transaction
  {
    id:               'FD00AFA8A0F7',
    type:             'debit',
    amount:           1600,
    effective_date:   '2014-09-21',
    first_name:       'marge',
    last_name:        'baker',
    address:          '101 2nd st',
    city:             'wellsville',
    state:            'KS',
    postal_code:      '66092',
    telephone:        '5858232966',
    account_type:     'checking',
    routing_number:   '103100195',
    account_number:   '3ACCOUNT234'
  }
end

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

def debugger_equal out, expected
  puts
  puts <<NACHA
# #{ %w[ 0 1 2 3 4 5 6 7 8 9 ].map { |i| i.to_s * 10 }.join('')[1..-1] }
# #{ '1234567890' * 10 }
O #{ out }
E #{ expected }
#
NACHA
  assert_equal out, expected
end

test 'generates the batch header' do
  batch = Guevara::Batch.new [ sample_transaction ], sample_options
  assert_equal batch.to_s.lines.to_a.first, <<NACHA
5200rubylit                                Ruby123PPD          140918140921   1123456780000001
NACHA
end

test 'generates the entry detail record' do
  batch = Guevara::Batch.new [ sample_transaction ], sample_options
  entry_detail = batch.to_s.lines.to_a[1]
  expected =
"6271031001953ACCOUNT234      0000001600FD00AFA8A0F7   marge baker             1123456780000001"

  assert_equal entry_detail, expected
end
