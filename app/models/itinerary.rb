class Itinerary
  attr_reader :airline, :raw, :segments, :id, :time
  
  def initialize(options = {})
    @airline = options[:airline]
    @raw = options[:raw]
    @segments = options[:segments]
    @id = options[:id]
    @time = options[:time]
  end
  
  def nodes
    segments.map { |s| [ s.origin_airport, s.destination_airport ] }.flatten.uniq
  end
  
  def self.from_hash(hsh)
    leg = hsh['legs']['leg']
    segments = case leg['segment']
    when Hash
      [Segment.from_hash(leg['segment'])]
    when Array
      leg['segment'].map { |s| Segment.from_hash s }
    end
    new :airline => leg['airline_display'], :raw => hsh, :segments => segments, :id => hsh['id'], :time => hsh['dt']
  end
end
