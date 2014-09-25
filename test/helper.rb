lib_path = File.absolute_path(File.join(__FILE__, '..', '..', 'lib'))
$LOAD_PATH.unshift(lib_path) unless $LOAD_PATH.include? lib_path

def sample_transaction
  {
    id:               'FD00AFA8A0F7',
    type:             'debit',
    amount:           1600,
    effective_date:   '2014-09-21',
    name:             'marge baker',
    first_name:       'marge',
    last_name:        'baker',
    additional_info:  'wellsville|KS|66092|101 2nd st|',
    telephone:        '5858232966',
    account_type:     'checking',
    routing_number:   103100195,
    account_number:   '3ACCOUNT234'
  }
end

def debugger_equal value, other
  flunk <<DEBUG unless value == other
Output is not as Expected
# #{ %w[ 0 1 2 3 4 5 6 7 8 9 ].map { |i| i.to_s * 10 }.join('')[1..-1] }
# #{ '1234567890' * 10 }
O#{ value.inspect }
E#{ other.inspect }

DEBUG
  success
end
