require 'rails_helper'

RSpec.describe 'munchies requests' do
  it 'has a successful response', :vcr do
    get '/api/v1/munchies?start=denver,co&destination=pueblo,co&food=chinese'
    binding.pry
  end
end
