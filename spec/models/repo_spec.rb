require 'rails_helper'

RSpec.describe Repo, type: :model do
  it 'exists' do 
    data = {}
    repo = Repo.new(data)

    expect(repo).to be_a(Repo)
  end 

  it 'has name and link data attributes' do 
    data = { name: 'Jennica', html_url: 'github.com' }
    repo = Repo.new(data)

    expect(repo.name).to eq('Jennica')
    expect(repo.link).to eq('github.com')
  end 
end
