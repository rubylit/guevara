require 'date'

module Guevara
  class Batch

    attr_reader :service_class, :options, :transactions
    
    def initialize(transactions, options)
      @service_class  = 200
      @options        = options
      @transactions   = transactions      
    end
  
    def to_s
      format "5%3d%-16.16s%-20.20s%10.10sPPD          %s%s   1%8d%07d\n",
        service_class,
        options[:company_name],
        '', # company discretionary data
        options[:company_id],
        Date.parse(options[:date]).strftime("%y%m%d"),
        effective_date.strftime("%y%m%d"),
        options[:routing_number],
        options[:index]
    end  
    
    def effective_date
      Date.parse transactions.first[:effective_date]
    end  
  end  
end
