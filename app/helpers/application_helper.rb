module ApplicationHelper
  def airline_image_tag(code)
    image_tag "http://www.kayak.com/v306/images/air/#{code.to_s.upcase}.gif", :alt => nil
  end
  
  def intermediation(itinerary)
    airports = itinerary.nodes
    if airports.tap(&:pop).tap(&:shift).empty?
      "non-stop"
    else
      "#{pluralize airports.length, 'stop'} (via #{ airports.to_sentence})"
    end
  end
  
  def link_to_itinerary_price(itinerary)
    link_to number_to_currency(itinerary.price, :unit => ''), "http://kayak.com#{itinerary.url}"
  end
end
