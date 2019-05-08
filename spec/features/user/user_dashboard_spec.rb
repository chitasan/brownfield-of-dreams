require 'rails_helper'

RSpec.describe 'Registered User' do
  describe 'can see on dashboard' do
    it 'section for Github with 5 repositories' do
      #this is currently passing as no OAuth yet
      VCR.use_cassette('facade/repos') do
        user = create(:user, token: "token 4b322bd9000db4338d619f6f49594fad4cf9df96")
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
        # binding.pry

        visit '/dashboard'
        expect(current_path).to eq(dashboard_path)

        expect(page).to have_content("GitHub")
        expect(page).to have_content("5 Repos:")

        within '.github_repos' do
          expect(page).to have_css('.repo-link')
        end
      end
    end

    xit "only user's own repo where then are multiple users in the database" do
      VCR.use_cassette('services/user_repos') do
        github_user = create(:user, token: ENV["GITHUB_USER_TOKEN"])
        non_github_user = create(:user, token: nil)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
        expect(GithubService).to receive(:initialize).with(user.token).one_time
        expect(GithubService).to_not receive(:initialize).with(user_2.token)

        visit '/dashboard'
        expect(page).to_not have_content(user_2.first_name)
      end
    end

    it "no 'Github' section if user is missing Github token" do
    end
  end
end
