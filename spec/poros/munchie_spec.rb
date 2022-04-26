require 'rails_helper'
RSpec.describe Munchie do
  it 'exists', :vcr do
    route = MapFacade.get_trip_info('Providence, RI', 'Boston, MA')
    munchies = MunchieFacade.get_munchies("Boston, MA", "chinese")
    munchie = Munchie.new(route, munchies)
    expect(munchie).to be_a Munchie
    expect(munchie.destination_city).to eq("Boston, MA")
    expect(munchie.travel_time).to eq("00:54:09")
    expect(munchie.forecast).to eq({:summary=>"broken clouds", :temperature=>55.94})
    expect(munchie.restaurant).to eq({:name=>"Q Restaurant", :address=>["660 Washington St", "Boston, MA 02111"]})
  end
end
