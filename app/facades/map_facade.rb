class MapFacade
  def self.get_trip_info(start, destination)
    route = MapService.get_travel_time(start, destination)
    weather = ForecastFacade.get_forecast(destination)
    info = {route: route, forecast: weather}
    return info
  end
end
#route[formattedTimeq]
