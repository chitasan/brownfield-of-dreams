require 'rails_helper'

RSpec.describe 'UserDashboardFacade' do 
  it 'exists' do 
    user = create(:user)
    facade = UserDashboardFacade.new(user)

    expect(facade).to be_a(UserDashboardFacade)
  end 

  describe 'instance methods' do 
    it '.header' do 
      VCR.use_cassette('services/get_repos') do
        github_user = create(:user, token: ENV["CHI_USER_TOKEN"])
        facade = UserDashboardFacade.new(github_user)

        expect(facade.header).to eq("5 Repos")
      end 
    end 

    it '.repos_top_five' do 
      VCR.use_cassette('services/get_repos') do
        github_user = create(:user, token: ENV["CHI_USER_TOKEN"])
        facade = UserDashboardFacade.new(github_user)

        expect(facade.repos_top_five.count).to eq(5)
      end 
    end 
  end 
end 