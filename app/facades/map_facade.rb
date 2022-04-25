class MapFacade
  def self.get_trip_info(start, destination)
    route = MapService.get_travel_time(start, destination)

  end
end
