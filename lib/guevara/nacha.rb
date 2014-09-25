module Guevara
  class Nacha

    def initialize batches
      @batches = batches
    end

    def to_s
      file = []
      file << file_header.to_s
      batches.each do |batch|
        file << batch.to_s
      end
      file << file_control.to_s
      file.join('')
    end

    def file_header
      FileHeader.new
        priority_code:    01,
        destination_id:   '12345678',
        origin_id:        '12345678',
        created_at:       '2014-11-28T13:30',
        id:               'A',
        destination_name: 'Rubylit',
        origin_name:      'Zest'
    end

  end
end
