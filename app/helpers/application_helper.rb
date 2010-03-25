module ApplicationHelper
  def airline_image_tag(code)
    image_tag "http://www.kayak.com/v306/images/air/#{code.to_s.upcase}.gif", :alt => nil
  end
  
  def intermediation(itinerary)
    airports = itinerary.nodes
    return if airports.tap(&:pop).tap(&:shift).empty?
    " (via #{ airports.to_sentence})"
  end
end
