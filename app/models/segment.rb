class Segment < Weary::Base
  attr_reader :origin_airport, :destination_airport, :aircraft, :airline_code, :calculation, :departure, :duration
  
  def initialize(options = {})
    @origin_airport = options[:origin_airport]
    @destination_airport = options[:destination_airport]
    @aircraft = options[:aircraft]
    @airline_code = options[:airline_code]
    @departure = options[:departure]
    @duration = options[:duration]
  end
  
  post :calculate do |resource|
    resource.url = 'http://carbon.brighterplanet.com/flights.json'
    resource.requires = [:'flight[origin_airport]', :'flight[destination_airport]', :'flight[airline]', :'flight[emplanements_per_trip]', :'flight[trips]']
  end
  
  def emission
    if ENV['FAKE'] == 'true'
      456
    else
      calculate!
      calculation[:emission]
    end
  end
  
  def methodology
    if ENV['FAKE'] == 'true'
      '#'
    else
      calculate!
      calculation[:methodology]
    end
  end
  
  def arrival
    departure + duration.minutes
  end
  
  def calculate!
    @calculation ||= calculate(:'flight[origin_airport]' => { :iata_code => origin_airport },
              :'flight[destination_airport]' => { :iata_code => destination_airport },
              :'flight[airline]' => { :iata => airline_code },
              :'flight[emplanements_per_trip]' => 1,
              :'flight[trips]' => 1
              ).perform.parse.symbolize_keys
  end
  
  def self.from_node(node)
    segment = {}
    segment[:airline_code] = node.at('airline').content
    segment[:origin_airport] = node.at('o').content
    segment[:destination_airport] = node.at('d').content
    segment[:aircraft] = node.at('equip').content
    segment[:departure] = DateTime.parse(node.at('dt').content)
    segment[:duration] = node.at('duration_minutes').content.to_i
    new segment
  end
  
end
