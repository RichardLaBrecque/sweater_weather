require 'rails_helper'
RSpec.describe 'Map Service' do
  it "can convert to lat and long", :vcr do
    convertion = MapService.convert("Providence, RI")
    expect(convertion).to be_a Hash
    expect(convertion).to have_key(:info)
    expect(convertion).to have_key(:results)
    expect(convertion[:results]).to be_a Array
    expect(convertion[:results][0]).to be_a Hash
    expect(convertion[:results][0]).to have_key(:locations)
    expect(convertion[:results][0][:locations]).to be_a Array
    expect(convertion[:results][0][:locations][0]).to be_a Hash
    expect(convertion[:results][0][:locations][0]).to have_key(:latLng)
  end
end
