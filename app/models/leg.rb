class Leg
  attr_reader :segments, :airline_code, :airline_name, :stops
  
  def initialize(options = {})
    @segments = options[:segments]
    @airline_code = options[:airline_code]
    @airline_name = options[:airline_name]
    @stops = options[:stops]
  end
  
  def emission
    segments.sum(&:emission)
  end
  
  def nodes
    segments.map { |s| [ s.origin_airport, s.destination_airport ] }.flatten.uniq
  end
  
  def self.from_node(node)
    leg = {}
    
    leg[:segments] = node.css('segment').map { |n| Segment.from_node n }
    leg[:airline_code] = node.at('airline').content
    leg[:airline_name] = node.at('airline_display').content
    leg[:start] = DateTime.parse node.at('depart').content
    leg[:end] = DateTime.parse node.at('arrive').content
    leg[:stops] = node.at('stops').content.to_i
    leg[:duration] = node.at('duration_minutes').content.to_f
    
    new leg
  end
end
