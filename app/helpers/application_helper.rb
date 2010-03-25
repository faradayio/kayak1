module ApplicationHelper
  def airline_image_tag(code)
    image_tag "http://www.kayak.com/v306/images/air/#{code.to_s.upcase}.gif", :alt => nil
  end
  
  def intermediation(itinerary)
    airports = itinerary.nodes
    return if airports.tap(&:pop).tap(&:shift).empty?
    " (via #{ airports.to_sentence})"
  end
  
  def link_to_itinerary_price(itinerary)
    link_to number_to_currency(itinerary.price), "http://kayak.com#{itinerary.url}"
  end
end
