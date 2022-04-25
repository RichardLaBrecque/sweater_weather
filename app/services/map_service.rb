class MapService
  def self.conn
    Faraday.new(url: "http://www.mapquestapi.com/geocoding/v1") do |faraday|
      faraday.params["key"] = ENV['map_api_key']
    end
  end
  def self.convert(location)
    response = conn.get("address?location=#{location}")
    JSON.parse(response.body, symbolize_names: true)
  end
end
