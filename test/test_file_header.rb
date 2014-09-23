require_relative 'helper.rb'
require_relative '../lib/guevara/file_header'

setup do
  Guevara::FileHeader.new(
    priority_code:    01,
    destination_id:   12345678,
    origin_id:        12345678,
    created_at:       '2014-11-28T13:30',
    id:               'A',
    destination_name: 'Rubylit',
    origin_name:      'Zest'
  )
end

test 'generates a full file' do |header|
  debugger_equal header.to_s, <<NACHA
101001234567800123456781411281330A094101                Rubylit                   Zest       0
NACHA
end

