require 'rails_helper'

RSpec.describe 'Munchie Service' do
  it 'can get the munchies', :vcr do
    munchies = MunchieService.get_munchies_at("Providence, RI", "chinese")
    expect(munchies).to be_a Hash
    expect(munchies).to have_key(:businesses)
    expect(munchies[:businesses]).to be_a Array
    expect(munchies[:businesses][0]).to be_a Hash
    expect(munchies[:businesses][0]).to have_key(:name)
    expect(munchies[:businesses][0]).to have_key(:location)
    expect(munchies[:businesses][0][:location]).to have_key(:display_address) 
  end
end
