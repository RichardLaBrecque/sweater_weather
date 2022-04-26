class BackgroundFacade
  def self.get_background(location)
    location_array = location.split(",")
    image = BackgroundService.get_background_image(location_array.first)
    Background.new(image, location)
  end
end
