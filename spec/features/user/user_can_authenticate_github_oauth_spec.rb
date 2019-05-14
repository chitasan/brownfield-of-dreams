require 'rails_helper'

RSpec.describe 'A Registered User' do 
  describe 'can connect to GitHub via OAuth' do 
    it 'through a button on /dashboard', :vcr do 
      OmniAuth.config.mock_auth[:github] = nil
      OmniAuth.config.test_mode = true
      OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
      provider: 'github',
      uid: '1',
      credentials: {
        token: ENV['CHI_USER_TOKEN']
      }
      })
      
      user = create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/dashboard'

      expect(current_path).to eq(dashboard_path)
      expect(page).to_not have_css('.github-repos')
      expect(page).to_not have_css('.followers')
      expect(page).to_not have_css('.followings')
      
      click_button('Connect to GitHub')
      
      expect(current_path).to eq(dashboard_path)

      expect(page).to have_content('GitHub')
      expect(page).to have_content('Followers')
      expect(page).to have_content('Following')

      within '.github_repos' do
        expect(page).to have_css('.repo-link', count: 5)
      end 
    end 
  end
end 