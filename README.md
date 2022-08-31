[![Gem Version](http://img.shields.io/gem/v/guevara.svg)](http://badge.fury.io/rb/guevara)
[![Build Status](http://img.shields.io/travis/rubylit/guevara.svg)](https://travis-ci.org/rubylit/guevara)
[![Code Climate](https://img.shields.io/codeclimate/maintainability/rubylit/guevara)](https://codeclimate.com/github/rubylit/guevara)
[![Inline docs](http://inch-ci.org/github/rubylit/guevara.png?branch=master)](http://inch-ci.org/github/rubylit/guevara)

# Guevara

Nacha file format is a pain, but with this gem the life will be easier
and the sun will shine for you :). [![Nacha Guevara](http://upload.wikimedia.org/wikipedia/commons/thumb/a/aa/Nacha_Guevara.jpg/289px-Nacha_Guevara.jpg)](http://es.wikipedia.org/wiki/Nacha_Guevara)

## Installation

    $ gem install guevara

## Usage

You need to build a big hash structure with all the required info,
create a `Guevara::Nacha` and call `to_s` to build the file.

~~~ruby
nacha = Guevara::Nacha.new(
  priority_code:    01,
  destination_id:   '12345678',
  origin_id:        '12345678',
  created_at:       '2014-11-28T13:30',
  id:               'A',
  destination_name: 'Rubylit',
  origin_name:      'Zest',
  batches:          [
    {
      service_class:  '200',
      company_name:   'rubylit',
      company_id:     'Ruby123',
      company_date:   '2014-09-18',
      origin_id:      '12345678',
      effective_date: '2014-09-21',
      transactions:   [{
        id:               'FD00AFA8A0F7',
        type:             'debit',
        amount:           1600,
        name:             'marge baker',
        additional_info:  'wellsville|KS|66092|101 2nd st|',
        telephone:        '5858232966',
        account_type:     'checking',
        routing_number:   103100195,
        account_number:   '3ACCOUNT234'
      }]
    }
  ]
)

nacha.to_s #=>
# 101001234567800123456781411281330A094101                Rubylit                   Zest       0
# 5200rubylit                                Ruby123PPD          140918140921   1123456780000001
# 6271031001953ACCOUNT234      0000001600FD00AFA8A0F7   marge baker             1123456780000001
# 705wellsville|KS|66092|101 2nd st|                                                 00010000001
# 82000000020010310019000000001600000000000000   Ruby123                         123456780000001
# 9000001000006000000020010310019000000001600000000000000                                       
~~~

## Contributing

1. Fork it ( https://github.com/rubylit/guevara/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## License

Copyright (C) 2014 Eloy Espinaco, Gaston Ramos

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
