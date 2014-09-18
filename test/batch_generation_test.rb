require_relative '../lib/guevara/batch'
def sample_transaction
  {
    id:               'FD00AFA8A0F7',
    type:             'debit',
    amount:           '1600',
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
    account_number:   '3423423253234'
  }
end

def sample_options
  {
    :routing_number => '12345678',
    :company_name   => 'rubylit',
    :company_id     => 'Ruby123',
    :date           => '2014-09-18',
    :index          => 1
  }
end

test 'generates the batch header' do
  batch = Guevara::Batch.new [ sample_transaction ], sample_options
  assert_equal batch.to_s.lines.to_a.first, <<NACHA
5200rubylit                                Ruby123PPD          140918140921   1123456780000001
NACHA
end
