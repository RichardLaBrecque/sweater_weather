class Api::V1::MunchiesController < ApplicationController
  def show
    route = MapFacade.get_trip_info(params[:start], params[:destination])
    munchies = MunchieFacade.get_munchies(params[:destination], params[:food])
    munchie = Munchie.new(route, munchies)
    render json: MunchieSerializer.new(munchie)
  end
end
