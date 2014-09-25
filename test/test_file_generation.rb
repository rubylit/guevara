require_relative 'helper.rb'
p $LOAD_PATH
require 'guevara'

test 'generates the batch' do |batch|

  transaction = {
    id:               'FD00AFA8A0F7',
    type:             'debit',
    amount:           1600,
    name:             'marge baker',
    additional_info:  'wellsville|KS|66092|101 2nd st|',
    telephone:        '5858232966',
    account_type:     'checking',
    routing_number:   103100195,
    account_number:   '3ACCOUNT234'
  }

  batch = {
    service_class:  '200',
    company_name:   'rubylit',
    company_id:     'Ruby123',
    company_date:   '2014-09-18',
    origin_id:      '12345678',
    effective_date: '2014-09-21',
    transactions:   [ transaction ]
  }

  nacha = Guevara::Nacha.new [ batch ]

  expected = <<NACHA
101001234567800123456781411281330A094101                Rubylit                   Zest       0
5200rubylit                                Ruby123PPD          140918140921   1123456780000001
6271031001953ACCOUNT234      0000001600FD00AFA8A0F7   marge baker             1123456780000001
705wellsville|KS|66092|101 2nd st|                                                 00010000001
82000000020010310019000000001600000000000000   Ruby123                         123456780000001
9000002000008000000040012249928000000012557000000000000                                       
NACHA

  nacha.to_s.lines.to_a.each_with_index do |line, index|
    debugger_equal line, expected.lines.to_a[index]
  end

end
