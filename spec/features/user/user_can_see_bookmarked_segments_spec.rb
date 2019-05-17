require 'rails_helper'

RSpec.describe 'A Registered User' do 
 describe 'can see under Bookmarked Segments section on /dashboard' do
    it 'all bookmarked segments' do
      user = create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      tutorial_1 = create(:tutorial, title: 'How to Tie Your Shoes')
      video_1 = create(:video, title: 'The Bunny Ears Technique', tutorial: tutorial_1)
      video_2 = create(:video, title: "I don't know how to tie my shoes", tutorial: tutorial_1)
      create(:user_video, user: user, video: video_1)
      create(:user_video, user: user, video: video_2)

      visit '/dashboard'

      expect(page).to have_content('Bookmarked Segments')

      within('.bookmarked') do
        expect(page).to have_content('The Bunny Ears Technique')
        expect(page).to have_content("I don't know how to tie my shoes")
      end
    end

    it 'segments are organized by which tutorial they are part of and then by position' do
      user = create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      tutorial_1 = create(:tutorial, title: 'How to Tie Your Shoes')
      video_1 = create(:video, title: 'The Bunny Ears Technique', tutorial: tutorial_1, position: 2)
      video_2 = create(:video, title: "I don't know how to tie my shoes", tutorial: tutorial_1, position: 1)
      create(:user_video, user: user, video: video_1)
      create(:user_video, user: user, video: video_2)

      tutorial_2 = create(:tutorial, title: 'How to Keep Plants Alive')
      video_3 = create(:video, title: 'Water Them', tutorial: tutorial_2, position: 1)
      video_4 = create(:video, title: 'Give Them Love and Sun', tutorial: tutorial_2, position: 2)
      create(:user_video, user: user, video: video_3)

      visit '/dashboard'

      within('.bookmarked') do
        expect(page).to have_content('How to Tie Your Shoes')
        expect(page).to have_content("I don't know how to tie my shoes")
        expect(page).to have_content('The Bunny Ears Technique')

        expect(page).to have_content('How to Keep Plants Alive')
        expect(page).to have_content('Water Them')
        expect(page).to_not have_content('Give Them Love and Sun')
      end
    end
  end
end
