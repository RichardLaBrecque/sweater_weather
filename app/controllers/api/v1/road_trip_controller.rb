class Api::V1::RoadTripController < ApplicationController
  def create
    if User.find_by(api_key: params[:api_key])
      trip = MapFacade.get_trip_info(params[:origin], params[:destination])
      if trip[:route][:info][:messages][0] == "We are unable to route with the given locations."
        render json: {data: {id: nil, type: "roadtrip", attributes:{ start_city: params[:origin], end_city: params[:destination], travel_time: "Impossible", weather_at_eta: {} }}}
      else
        road_trip = RoadTrip.new(trip)
        render json: RoadtripSerializer.new(road_trip)
      end
    else
      render json: {data: {message: "ACCESS DENIED"}}
    end
  end
end
