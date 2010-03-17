class Search < Weary::Base
  attr_reader :origin_airport, :destination_airport, :search_id, :session_id
  
  def initialize(options = {})
    @origin_airport = options[:origin_airport]
    @destination_airport = options[:destination_airport]
  end
  
  def perform!
    kayak_session = session(:token => KAYAK_DEVELOPER_KEY).perform
    @session_id = kayak_session.parse['ident']['sid']
    kayak_search_request = search(self.class.defaults.merge(:origin => origin_airport, :destination => destination_airport, :_sid_ => session_id))
    kayak_search = kayak_search_request.perform
    @search_id = kayak_search.parse['search']['searchid']
    @cluster_cookie = kayak_search.header["set-cookie"].find { |c| c.match(/^cluster/)}
  end
  
  post :session do |resource|
    resource.url = 'http://api.kayak.com/k/ident/apisession'
    resource.requires = [:token]
  end

  post :search do |resource|
    resource.url = 'http://api.kayak.com/s/apisearch'
    resource.requires = [:origin, :destination, :_sid_, :basicmode, :oneway, :depart_date, :depart_time, :travelers, :cabin, :action, :apimode]
  end
  
  post :results do |resource|
    resource.url = 'http://api.kayak.com/s/apibasic/flight'
    resource.requires = [:_sid_, :searchid, :c, :m, :d, :s, :version, :apimode]
    resource.headers = { 'Cookie' => @cluster_cookie }
  end

  def itineraries
    results(self.class.defaults.merge(:_sid_ => @session_id, :searchid => @search_id)).perform
  end
  
  def self.defaults
    { :basicmode => true, :oneway => 'y', :depart_date => Date.today.tomorrow.tomorrow.strftime('%m/%d/%Y'), :depart_time => 'a', :travelers => 1, :cabin => 'e', :action => 'doFlights', :apimode => 1, :c => 5, :m => 'normal', :d => 'up', :s => 'price', :version => 1 }
  end
  
end
