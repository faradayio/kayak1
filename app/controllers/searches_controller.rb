class SearchesController < ApplicationController
  def new
    @search = Search.new
  end
  
  def create
    @search = Search.new(params.symbolize_keys.slice(:origin_airport, :destination_airport, :date, :round_trip, :return_date))
    if ENV['FAKE'] == 'true'
      xml = open(File.join(Rails.root, 'doc', 'kayak_response.xml'))
    else
      @search.perform!
      sleep 1 while @search.continue?
      xml = @search.itineraries.body
    end
    @itineraries = Nokogiri::XML(xml).css('searchresult trips trip').to_a.map { |node| Itinerary.from_node node }[0..(RESULTS_TO_FETCH - 1)]
    render :action => :show
  end
end
