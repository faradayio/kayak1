class SearchesController < ApplicationController
  def new
    @search = Search.new
  end
  
  def create
    @search = Search.new(params.symbolize_keys.slice(:origin_airport, :destination_airport, :date)).tap(&:perform!)
    sleep 3
    @itineraries = Nokogiri::XML(@search.itineraries.body).css('searchresult trips trip').to_a.map { |node| Itinerary.from_node node }
    render :action => :show
  end
end
