class Itinerary
  attr_reader :legs, :price, :url, :start, :end, :stops, :duration
  
  def initialize(options = {})
    @legs = options[:legs]
    @id = options[:id]
    @time = options[:time]
    @start = options[:start]
    @end = options[:end]
    @duration = options[:duration]
    @price = options[:price]
    @stops = options[:stops]
    @url = options[:url]
  end
  
  def emission
    legs.sum(&:emission)
  end
  
  def nodes
    legs.sum(&:nodes).uniq
  end
  
  def airline_name
    legs.first.airline_name
  end
  
  def airline_code
    legs.first.airline_code
  end
  
  def self.from_node(node)
    itinerary = {}

    itinerary[:url] = node.at('price').attribute('url').value
    itinerary[:price] = node.at('price').content.sub('$', '')
    itinerary[:legs] = node.css('legs leg').map { |n| Leg.from_node n }
    
    new itinerary
  end
end
