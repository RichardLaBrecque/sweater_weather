require 'rails_helper'

RSpec.describe 'munchies requests' do
  it 'has a successful response', :vcr do
    get '/api/v1/munchies?start=denver,co&destination=pueblo,co&food=chinese'
    munchie = JSON.parse(response.body, symbolize_names: true)
    expect(response).to be_successful
    expect(munchie).to be_a Hash
    expect(munchie).to have_key(:data)
    expect(munchie[:data]).to have_key(:id)
    expect(munchie[:data]).to have_key(:type)
    expect(munchie[:data][:type]).to eq("munchie")
    expect(munchie[:data]).to have_key(:attributes)
    expect(munchie[:data][:attributes]).to have_key(:destination)
    expect(munchie[:data][:attributes]).to have_key(:travel_time)
    expect(munchie[:data][:attributes]).to have_key(:forecast)
    expect(munchie[:data][:attributes]).to have_key(:restaurant)
    binding.pry
  end
end
