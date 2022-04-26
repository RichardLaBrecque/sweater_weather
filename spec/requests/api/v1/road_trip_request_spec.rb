require 'rails_helper'

RSpec.describe 'Road Trip Requests' do
  it 'can plan a road trip', :vcr do
    user = User.create!(email: "useremail@email.com", password: "password", password_confirmation: "password")
    data = {
  "origin": "Denver,CO",
  "destination": "Pueblo,CO",
  "api_key": "#{user.api_key}"
  }
  headers = { 'CONTENT_TYPE' => 'application/json', "Accept" => 'application/json'}
    post "/api/v1/road_trip", headers: headers, params: JSON.generate(data)
    reply = JSON.parse(response.body, symbolize_names: true)
    expect(reply).to have_key(:data)
    expect(reply[:data]).to have_key(:id)
    expect(reply[:data]).to have_key(:type)
    expect(reply[:data][:type]).to eq("roadtrip")
    expect(reply[:data]).to have_key(:attributes)
    expect(reply[:data][:attributes]).to have_key(:start_city)
    expect(reply[:data][:attributes]).to have_key(:end_city)
    expect(reply[:data][:attributes]).to have_key(:travel_time)
    expect(reply[:data][:attributes]).to have_key(:weather_at_eta)
    expect(reply[:data][:attributes][:weather_at_eta]).to have_key(:temperature)
    expect(reply[:data][:attributes][:weather_at_eta]).to have_key(:conditions)
  end

  it 'can plan a longer road trip', :vcr do
    user = User.create!(email: "useremail@email.com", password: "password", password_confirmation: "password")
    data = {
  "origin": "Denver,CO",
  "destination": "New York City, NY",
  "api_key": "#{user.api_key}"
  }
  headers = { 'CONTENT_TYPE' => 'application/json', "Accept" => 'application/json'}
    post "/api/v1/road_trip", headers: headers, params: JSON.generate(data)
    reply = JSON.parse(response.body, symbolize_names: true)
    expect(reply).to have_key(:data)
    expect(reply[:data]).to have_key(:id)
    expect(reply[:data]).to have_key(:type)
    expect(reply[:data][:type]).to eq("roadtrip")
    expect(reply[:data]).to have_key(:attributes)
    expect(reply[:data][:attributes]).to have_key(:start_city)
    expect(reply[:data][:attributes]).to have_key(:end_city)
    expect(reply[:data][:attributes]).to have_key(:travel_time)
    expect(reply[:data][:attributes]).to have_key(:weather_at_eta)
    expect(reply[:data][:attributes][:weather_at_eta]).to have_key(:temperature)
    expect(reply[:data][:attributes][:weather_at_eta]).to have_key(:conditions)
  end

  it 'cant plan an imposible trip', :vcr do
    user = User.create!(email: "useremail@email.com", password: "password", password_confirmation: "password")
    data = {
  "origin": "Denver,CO",
  "destination": "London, UK",
  "api_key": "#{user.api_key}"
  }
  headers = { 'CONTENT_TYPE' => 'application/json', "Accept" => 'application/json'}
    post "/api/v1/road_trip", headers: headers, params: JSON.generate(data)
    reply = JSON.parse(response.body, symbolize_names: true)
    expect(reply).to have_key(:data)
    expect(reply[:data]).to have_key(:id)
    expect(reply[:data]).to have_key(:type)
    expect(reply[:data][:type]).to eq("roadtrip")
    expect(reply[:data]).to have_key(:attributes)
    expect(reply[:data][:attributes]).to have_key(:start_city)
    expect(reply[:data][:attributes]).to have_key(:end_city)
    expect(reply[:data][:attributes]).to have_key(:travel_time)
    expect(reply[:data][:attributes][:travel_time]).to eq("Impossible")
    expect(reply[:data][:attributes]).to have_key(:weather_at_eta)
    expect(reply[:data][:attributes][:weather_at_eta]).to_not have_key(:temperature)
    expect(reply[:data][:attributes][:weather_at_eta]).to_not have_key(:conditions)
  end
end
