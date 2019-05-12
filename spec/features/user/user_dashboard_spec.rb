require 'rails_helper'

RSpec.describe 'Registered User' do
  describe 'can see on dashboard' do
    it 'section for Github with 5 repositories' do
      VCR.use_cassette('services/get_repos') do
        github_user = create(:user, token: ENV["CHI_USER_TOKEN"])

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(github_user)

        visit '/dashboard'
        expect(current_path).to eq(dashboard_path)

        expect(page).to have_content("GitHub")
        expect(page).to have_content("5 Repos")

        within '.github_repos' do
          expect(page).to have_css('.repo-link')
        end
      end
    end

    it "only user's own repo where then are multiple users in the database" do
      VCR.use_cassette('services/get_repos') do
        github_user = create(:user, token: ENV["CHI_USER_TOKEN"])
        non_github_user = create(:user, token: nil, first_name: "Chi")
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(github_user)

        visit '/dashboard'
        expect(page).to_not have_content(non_github_user.first_name)
        expect(page).to have_content(github_user.first_name)
      end
    end

    it "no 'Github' section if user is missing Github token" do
      VCR.use_cassette('services/get_repos') do
        non_github_user = create(:user, token: nil, first_name: "Chi")
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(non_github_user)

        visit '/dashboard'
        expect(page).to have_content(non_github_user.first_name)
        expect(page).to_not have_content("GitHub")
        expect(page).to_not have_content("Repos")
      end
    end

    it 'can see subsection under Github called Followers' do 
      VCR.use_cassette('services/get_followers') do
      github_user = create(:user, token: ENV["CHI_USER_TOKEN"])
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(github_user)

      visit '/dashboard'
      expect(page).to have_content('Followers')

        within '.followers' do
          expect(page).to have_css('#follower_handle')
          expect(page).to have_css('.follower_link')
        end
      end 
    end 
  end
end
