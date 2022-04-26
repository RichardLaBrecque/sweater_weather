class MapService
  def self.conn
    Faraday.new(url: "http://www.mapquestapi.com") do |faraday|
      faraday.params["key"] = ENV['map_api_key']
    end
  end
  def self.convert(location)
    response = conn.get("geocoding/v1/address?location=#{location}")
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.get_travel_time(start, destination)
    response = conn.get("directions/v2/route") do |map|
      map.params[:from] = start
      map.params[:to] = destination
    end
    JSON.parse(response.body, symbolize_names: true)
  end
end
