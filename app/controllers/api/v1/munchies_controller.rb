class Api::V1::MunchiesController < ApplicationController
  def show
    route = MapFacade.get_trip_info(params[:start], params[:destination])
    binding.pry
  end
end
