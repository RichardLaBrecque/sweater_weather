class WeatherService
  def self.conn
    Faraday.new(url: "https://api.openweathermap.org/data/2.5") do |faraday|
      faraday.params[:appid] = ENV["weather_key"]
    end
  end
  def self.current_forcast(location)
    response = conn.get("onecall?lat=#{location[:lat]}&lon=#{location[:lng]}&exclude=minutely,alerts&units=imperial")
    JSON.parse(response.body, symbolize_names: true)
  end
end
