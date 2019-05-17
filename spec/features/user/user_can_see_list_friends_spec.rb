require 'rails_helper'

describe "a registered user" do
  describe "on their dashboard" do
    it "can see a list of friends" do
      github_user = create(:user, token: ENV["CHI_USER_TOKEN"], uid:"2")
      friend = create(:user, token: ENV["CHI_USER_TOKEN"], uid:"3")
      friend2 = create(:user, uid:"4")
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(github_user)
      visit '/dashboard'
      expect(page).to have_content("Friends")
      expect(page).to have_css(".friends")
      within(first('.friend')) do
        expect(page).to have_css('.friend-name')
      end
    end
    it "can add a friendship" do
      github_user = User.create(token: ENV["CHI_USER_TOKEN"], uid:"44073660", first_name: "Chi", password:"pw", last_name: "c")
      jen = User.create(token: ENV["JENNICA_USER_TOKEN"], uid:"25069483", first_name: "Jennica", password:"pw", last_name: "c")
      stoovies = User.create(uid:"35910428", first_name: "stoovies", last_name:"s", password:"pw")
      data = [{:login=>"sojurner",
                  :id=>35910428,
                  :html_url=>"https://github.com/sojurner"},
                 {:login=>"Stoovles",
                  :id=>40487417,
                  :html_url=>"https://github.com/Stoovles"},
                 {:login=>"stiehlrod",
                  :id=>25069483,
                  :html_url=>"https://github.com/stiehlrod"},
                 {:login=>"jalena-penaligon",
                  :id=>45905026,
                  :html_url=>"https://github.com/jalena-penaligon"}
                ]
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(github_user)

      visit '/dashboard'
      save_and_open_page
      within(first('.friend')) do
        expect(page).to_not have_content(amy.first_name)
      end
      within(first('.follower')) do
        expect(page).to have_link("Add Friend")
        click_on "Add Friend"
      end
      expect(current_path).to eq('/dashboard')
      within(first('.friend')) do
        expect(page).to have_content(amy.first_name)
      end
    end
  end
end
