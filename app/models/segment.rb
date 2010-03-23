class Segment < Weary::Base
  attr_reader :origin_airport, :destination_airport, :aircraft, :seat_class, :airline
  
  def initialize(options = {})
    @origin_airport = options[:origin_airport]
    @destination_airport = options[:destination_airport]
    @aircraft = options[:aircraft]
    @seat_class = options[:seat_class]
    @airline = options[:airline]
  end
  
  post :calculate do |resource|
    resource.url = 'http://carbon.brighterplanet.com/flights.json'
    resource.requires = [:'flight[origin_airport]', :'flight[destination_airport]', :'flight[airline]', :'flight[emplanements_per_trip]', :'flight[trips]']
  end
  
  def emission
    calculate(:'flight[origin_airport]' => { :iata_code => origin_airport },
              :'flight[destination_airport]' => { :iata_code => destination_airport },
              :'flight[airline]' => { :iata_code => airline },
              :'flight[emplanements_per_trip]' => 1,
              :'flight[trips]' => 1
              ).perform.parse.symbolize_keys[:emission]
  end
  
  def self.from_hash(hsh)
    new :origin_airport => hsh['o'], :destination_airport => hsh['d'], :airline => hsh['airline']
  end
  
end
