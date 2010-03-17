class SearchesController < ApplicationController
  def new
    @search = Search.new
  end
  
  def create
    @search = Search.new params[:search]
    if @search.save
      redirect_to @search
    else
      flash[:notice] = 'There was a problem with your search'
      render :action => :new
    end
  end
  
  def show
    @search = Search.find params[:id]
  end
end
