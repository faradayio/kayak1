class SearchesController < ApplicationController
  def new
    @search = Search.new
  end
  
  def create
    @search = Search.new params.symbolize_keys.slice(:origin_airport, :destination_airport)
    logger.info @search.inspect
    @search.perform!
    logger.info "Sleeping"
    sleep 10
    render :text => @search.itineraries.body, :format => :xml
  end
end
