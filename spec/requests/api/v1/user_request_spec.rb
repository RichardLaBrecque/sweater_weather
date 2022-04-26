require 'rails_helper'
RSpec.describe 'user requests' do
  it 'returns a user email' do
    data = { "email": "useremail@email.com",
            "password": "password",
            "password_confirmation": "password"}
    headers = { 'CONTENT_TYPE' => 'application/json', "Accept" => 'application/json'}
  post '/api/v1/users', headers: headers, params: JSON.generate(data)
  reply = JSON.parse(response.body, symbolize_names: true)
  expect(reply).to be_a Hash
  expect(reply).to have_key(:data)
  expect(reply[:data]).to have_key(:id)
  expect(reply[:data]).to have_key(:type)
  expect(reply[:data]).to have_key(:attributes)
  expect(reply[:data][:type]).to eq("user")
  expect(reply[:data][:attributes]).to have_key(:email)
  expect(reply[:data][:attributes]).to have_key(:api_key)
  expect(reply[:data][:attributes]).to_not have_key(:password)
  end

  it 'returns a an error for missmatched emails' do
    data = { "email": "useremail@email.com",
            "password": "padsfd",
            "password_confirmation": "password"}
    headers = { 'CONTENT_TYPE' => 'application/json', "Accept" => 'application/json'}
  post '/api/v1/users', headers: headers, params: JSON.generate(data)
  reply = JSON.parse(response.body, symbolize_names: true)
  expect(response.status).to eq(400)
  expect(reply).to have_key(:data)
  expect(reply[:data]).to have_key(:message)
  expect(reply[:data][:message]).to eq("passwords do not match")
  end

  it 'returns and error for duplicated emails' do
    user = User.create!(email: "useremail@email.com", password: "password", password_confirmation: "password")
    data = { "email": "useremail@email.com",
            "password": "password",
            "password_confirmation": "password"}
    headers = { 'CONTENT_TYPE' => 'application/json', "Accept" => 'application/json'}
  post '/api/v1/users', headers: headers, params: JSON.generate(data)
  reply = JSON.parse(response.body, symbolize_names: true)
  expect(response.status).to eq(400)
  expect(reply).to have_key(:data)
  expect(reply[:data]).to have_key(:message)
  expect(reply[:data][:message]).to eq("that email already exists")
  end

  it 'handles other errors' do
    data = { "email": nil,
            "password": nil,
            "password_confirmation": nil}
    headers = { 'CONTENT_TYPE' => 'application/json', "Accept" => 'application/json'}
  post '/api/v1/users', headers: headers, params: JSON.generate(data)
  reply = JSON.parse(response.body, symbolize_names: true)
  expect(response.status).to eq(400)
  expect(reply[:data][:message]).to eq("unable to create user")
  end
end
