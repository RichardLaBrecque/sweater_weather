class Munchie
  attr_reader :id, :destination_city, :travel_time, :forecast, :restaurant
  def initialize(route, restaurants)
    @id
    @destination_city = "#{route[:route][:route][:locations][1][:adminArea5]}, #{route[:route][:route][:locations][1][:adminArea3]}"
    @travel_time = route[:route][:route][:formattedTime]
    @forecast = {summary: route[:forecast].current_weather[:conditions] , temperature: route[:forecast].current_weather[:temp]}
    @restaurant = {name: restaurants[:businesses][0][:name], address: restaurants[:businesses][0][:location][:display_address]}
  end
end
