require 'rails_helper'

 RSpec.describe Following, type: :model do
  it 'exists' do
    data = {}
    following = Following.new(data)

     expect(following).to be_a(Following)
  end

   it 'has handle and link data attributes' do
    data = { login: 'sojurner', html_url: 'https://github.com/sojurner' }
    following = Following.new(data)

     expect(following.handle).to eq('sojurner')
    expect(following.link).to eq('https://github.com/sojurner')
  end
end
