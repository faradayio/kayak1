class SearchesController < ApplicationController
  def new
    @search = Search.new
  end
  
  def create
    @search = Search.new(params.symbolize_keys.slice(:origin_airport, :destination_airport, :date))
    if ENV['FAKE'] == 'true'
      xml = open(File.join(Rails.root, 'doc', 'kayak_response.xml'))
    else
      @search.perform!
      sleep 3
      xml = @search.itineraries.body
    end
    @itineraries = Nokogiri::XML(xml).css('searchresult trips trip').to_a.map { |node| Itinerary.from_node node }[0..5]
    render :action => :show
  end
end
