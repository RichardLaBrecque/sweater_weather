class RoadTrip
  attr_reader :id, :start_city, :end_city, :weather_at_eta, :travel_time
  def initialize(trip_hash)
    @id
    @start_city = "#{trip_hash[:route][:route][:locations][0][:adminArea5]}, #{trip_hash[:route][:route][:locations][0][:adminArea3]}"
    @end_city = "#{trip_hash[:route][:route][:locations][1][:adminArea5]}, #{trip_hash[:route][:route][:locations][1][:adminArea3]}"
    @travel_time = trip_hash[:route][:route][:formattedTime]
    @weather_at_eta = {}
    @forecast = trip_hash[:forecast]
    @travel_time_raw = trip_hash[:route][:route][:realTime]
    set_weather
  end

  def set_weather
    forecast_index =  ((@travel_time_raw/3600.00).round) -1
    if forecast_index <= 1
      @weather_at_eta = {"temperature": @forecast.current_weather[:temp], "conditions": @forecast.current_weather[:conditions]}
    elsif forecast_index > 1 && forecast_index <= 8
      @weather_at_eta =  {"temperature": @forecast.hourly_weather[forecast_index][:temp], "conditions": @forecast.hourly_weather[forecast_index][:conditions]}
    else forecast_index > 8
      daily_index = forecast_index / 24
      if daily_index <= 5
        @weather_at_eta =  {"temperature": @forecast.daily_weather[daily_index][:max_temp], "conditions": @forecast.daily_weather[daily_index][:conditions]}
      else
        @weather_at_eta = { message: "damn thats a long trip"}
      end
    end
  end
end
