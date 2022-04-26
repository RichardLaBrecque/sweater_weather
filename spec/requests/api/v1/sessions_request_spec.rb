require 'rails_helper'

RSpec.describe "sessions requests" do
  it 'returns an existing user and api key' do
    user = User.create!(email: "whatever@example.com", password: "password", password_confirmation: "password")
    data = {  'email': 'whatever@example.com',
              'password': 'password'
            }
    headers = { 'CONTENT_TYPE' => 'application/json', "Accept" => 'application/json'}
    post '/api/v1/sessions', headers: headers, params: JSON.generate(data)
    reply = JSON.parse(response.body, symbolize_names: true)
    expect(reply).to have_key(:data)
    expect(reply[:data]).to have_key(:id)
    expect(reply[:data]).to have_key(:type)
    expect(reply[:data]).to have_key(:attributes)
    expect(reply[:data][:attributes]).to have_key(:email)
    expect(reply[:data][:attributes]).to have_key(:api_key)
    expect(reply[:data][:attributes]).to_not have_key(:password_digest)
  end
  it 'returns an error for bad password' do
    user = User.create!(email: "whatever@example.com", password: "password", password_confirmation: "password")
    data = {  'email': 'whatever@example.com',
              'password': 'pasdfrd'
            }
    headers = { 'CONTENT_TYPE' => 'application/json', "Accept" => 'application/json'}
    post '/api/v1/sessions', headers: headers, params: JSON.generate(data)
    reply = JSON.parse(response.body, symbolize_names: true)
    expect(reply).to have_key(:data)
    expect(reply[:data]).to have_key(:message)
    expect(reply[:data][:message]).to eq("well thats not right, try something different")
  end
end
