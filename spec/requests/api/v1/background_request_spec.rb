require 'rails_helper'

RSpec.describe 'bacground image requests' do
  it 'can get a background image', :vcr do
    get '/api/v1/backgrounds?location=denver,co'
    expect(response).to be_successful
    image = JSON.parse(response.body, symbolize_names: true)
    expect(image).to be_a Hash
    expect(image).to have_key(:data)
    expect(image[:data]).to have_key(:id)
    expect(image[:data]).to have_key(:type)
    expect(image[:data]).to have_key(:attributes)
    expect(image[:data][:attributes]).to have_key(:image)
  end
end
