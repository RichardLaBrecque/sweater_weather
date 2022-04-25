class ForecastFacade
  def self.get_forecast(location)
    coords = MapService.convert(location)
    weather = WeatherService.current_forcast(coords[:results].first[:locations].first[:latLng])
    Forecast.new(weather)
  end
end
