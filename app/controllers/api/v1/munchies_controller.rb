class Api::V1::MunchiesController < ApplicationController
  def show
    route = MapFacade.get_trip_info(params[:start], params[:destination])
    munchies = MunchieFacade.get_munchies(params[:destination], params[:food])
    binding.pry
  end
end
