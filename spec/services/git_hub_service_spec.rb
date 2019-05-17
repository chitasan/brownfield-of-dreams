require 'rails_helper'

RSpec.describe 'GitHubService' do 
  it 'exists' do 
    user = create(:user)
    service = GitHubService.new(user)

    expect(service).to be_a(GitHubService)
  end 

  describe 'instance methods' do 
    it '.get_repos' do 
      VCR.use_cassette('services/get_repos') do
        github_user = create(:user, token: ENV["CHI_USER_TOKEN"])
        service = GitHubService.new(github_user)
      
        repos = service.repos
   
        expect(repos.first).to have_key(:name)
        expect(repos.first).to have_key(:html_url)
        expect(repos.last).to have_key(:name)
        expect(repos.last).to have_key(:html_url)
      end 

    end 
    it '.get_followers' do 
      VCR.use_cassette('services/get_followers') do
        github_user = create(:user, token: ENV["CHI_USER_TOKEN"])
        service = GitHubService.new(github_user)
      
        followers = service.followers
   
        expect(followers.first).to have_key(:login)
        expect(followers.first).to have_key(:html_url)
        expect(followers.last).to have_key(:login)
        expect(followers.last).to have_key(:html_url)
      end 
    end 
  end 
end 