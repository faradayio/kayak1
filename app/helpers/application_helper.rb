module ApplicationHelper
  def airline_image_tag(code)
    image_tag "http://www.kayak.com/v306/images/air/#{code.to_s.upcase}.gif", :alt => nil
  end
end
