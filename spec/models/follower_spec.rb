require 'rails_helper'

RSpec.describe Follower, type: :model do
  it 'exists' do 
    data = {}
    follower = Follower.new(data)

    expect(follower).to be_a(Follower)
  end 

  it 'has handle and link data attributes' do 
    data = { login: 'sojurner', html_url: 'https://github.com/sojurner' }
    follower = Follower.new(data)

    expect(follower.handle).to eq('sojurner')
    expect(follower.link).to eq('https://github.com/sojurner')
  end 
end
