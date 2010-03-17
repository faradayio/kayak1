class SearchesController < ApplicationController
  def new
    @search = Search.new
  end
  
  def create
    @search = Search.new params.symbolize_keys.slice(:origin_airport, :destination_airport)
    @search.perform!
    sleep 10
    @itineraries = @search.itineraries.parse['searchresult']['trips']['trip'].map { |t| Itinerary.from_xml t }
    Rails.logger.info @itineraries.inspect
    render :action => :show
  end
end
