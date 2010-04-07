module ApplicationHelper
  def airline_image_tag(code)
    image_tag "http://www.kayak.com/v306/images/air/#{code.to_s.upcase}.gif", :alt => nil
  end
  
  def intermediation(trip)
    case trip
    when Itinerary
      if trip.legs.length == 1
        intermediation trip.legs.first
      else
        if trip.legs.map { |leg| leg.nodes.tap(&:pop).tap(&:shift).to_set }.uniq.length == 1
          "#{intermediation trip.legs.first} both ways"
        else
          "#{intermediation trip.legs.first} there, #{intermediation trip.legs.last} back"
        end
      end
    when Leg
      if trip.stops == 0
        "non-stop"
      else
        "#{pluralize trip.stops, 'stop'} (via #{ trip.nodes.tap(&:pop).tap(&:shift).to_sentence})"
      end
    end
  end
  
  def link_to_itinerary_price(itinerary)
    link_to "<strong class=\"currency\">#{ number_to_currency(itinerary.price, :unit => '') }</strong><br />book now", "http://kayak.com#{itinerary.url}"
  end
end
