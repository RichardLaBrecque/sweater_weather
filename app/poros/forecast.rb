class Forecast
  attr_reader :id, :current_weather, :daily_weather, :hourly_weather
  def initialize(forecast_hash)
    @id
    @current_weather = {}
    @daily_weather = {}
    @hourly_weather = {}
    format_forecast(forecast_hash)
  end

  def format_forecast(hash)
    current_weather_raw = hash[:current]
    @current_weather = {datetime: Time.at(current_weather_raw[:dt]).to_datetime,
                        sunrise: Time.at(current_weather_raw[:sunrise]).to_datetime,
                        sunset: Time.at(current_weather_raw[:sunset]).to_datetime,
                        temp: current_weather_raw[:temp],
                        feels_like: current_weather_raw[:feels_like],
                        humidity: current_weather_raw[:humidity],
                        uvi: current_weather_raw[:uvi],
                        visibility: current_weather_raw[:visibility],
                        conditions: current_weather_raw[:weather][0][:description],
                        icon: current_weather_raw[:weather][0][:icon]
                  }
    daily_weather_raw = hash[:daily].first(5)
    @daily_weather = daily_weather_raw.map do |daily|
      {date: Time.at(daily[:dt]).to_date,
      sunrise: Time.at(daily[:sunrise]).to_datetime,
      sunset: Time.at(daily[:sunset]).to_datetime,
      max_temp: daily[:temp][:max],
      min_temp: daily[:temp][:min],
      conditions: daily[:weather][0][:description],
      icon: daily[:weather][0][:icon]
  }
    end
    hourly_weather_raw = hash[:hourly].first(8)
    @hourly_weather = hourly_weather_raw.map do |hourly|
      {time: Time.at(hourly[:dt]),
      temp: hourly[:temp],
      conditions: hourly[:weather][0][:description],
      icon: hourly[:weather][0][:icon]}
    end
  end
end
