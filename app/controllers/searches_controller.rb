class SearchesController < ApplicationController
  def new
    @search = Search.new
  end
  
  def create
    @search = Search.new(params.symbolize_keys.slice(:origin_airport, :destination_airport, :date)).tap(&:perform!)
    sleep 1
    @itineraries = @search.itineraries.parse['searchresult']['trips']['trip'].map { |t| Itinerary.from_hash t }
    render :action => :show
  end
end
