class Itinerary
  attr_reader :segments, :price, :url, :airline_code, :airline_name, :start, :end, :stops, :duration
  
  def initialize(options = {})
    @segments = options[:segments]
    @id = options[:id]
    @time = options[:time]
    @airline_code = options[:airline_code]
    @airline_name = options[:airline_name]
    @start = options[:start]
    @end = options[:end]
    @duration = options[:duration]
    @price = options[:price]
    
  end
  
  def nodes
    segments.map { |s| [ s.origin_airport, s.destination_airport ] }.flatten.uniq
  end
  
  def self.from_node(node)
    itinerary = {}
    itinerary[:url] = node.at('price').attribute('url').value
    itinerary[:price] = node.at('price').content

    leg = node.at('legs leg')
    itinerary[:segments] = leg.css('segment').map { |n| Segment.from_node n }
    itinerary[:airline_code] = leg.at('airline').content
    itinerary[:airline_name] = leg.at('airline_display').content
    itinerary[:start] = DateTime.parse leg.at('depart').content
    itinerary[:end] = DateTime.parse leg.at('arrive').content
    itinerary[:stops] = leg.at('stops').content.to_i
    itinerary[:duration] = leg.at('duration_minutes').content.to_f
    
    new itinerary
  end
end
