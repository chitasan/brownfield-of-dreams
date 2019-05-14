require 'rails_helper'
RSpec.describe 'Registered user' do
  describe 'can create a friendship' do
    it 'can click on a button to add a friend' do
      initiator = User.new(email: "email@gmail1.com", first_name: "jo", last_name: "smith", password: "p1")
      recipient = User.new(email: "email@gmail2.com", first_name: "jo", last_name: "smith", password: "p1")
      visit '/dashboard'
      # expect(page).to have_content(recipient.first_name)
      click_on "Add friend"
      expect(current_path).to eq("/dashboard")
      expect(page).to have_content("Friends List")
      expect(page).to have_css('.friends', count: 10)
      within(first('.friends')) do
        expect(page).to have_css('.friends-first-name')
        expect(page).to have_css('.friends-last-name')
      end
    end
  end
end
