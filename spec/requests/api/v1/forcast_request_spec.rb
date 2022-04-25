require 'rails_helper'

RSpec.describe "Forcast requests" do
  it 'can get a forcast for denver', :vcr do
    get '/api/v1/forecast?location=denver,co'
    expect(response).to be_successful
    forecast = JSON.parse(response.body, symbolize_names: true)
    binding.pry
    expect(forecast).to have_key(:data)
    expect(forecast[:data]).to have_key(:type)
    expect(forecast[:data]).to have_key(:attributes)
    expect(forecast[:data][:attributes]).to have_key(:current_weather)
    expect(forecast[:data][:attributes][:current_weather]).to have_key()
    expect(forecast[:data][:attributes]).to have_key(:daily_weather)
    expect(forecast[:data][:attributes]).to have_key(:hourly_weather)
  end
end
