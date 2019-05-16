require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:email)}
    it {should validate_presence_of(:first_name)}
    it {should validate_presence_of(:password)}
  end

  describe 'roles' do
    it 'can be created as default user' do
      user = User.create(email: 'user@email.com', password: 'password', first_name:'Jim', role: 0)

      expect(user.role).to eq('default')
      expect(user.default?).to be_truthy
    end

    it 'can be created as an Admin user' do
      admin = User.create(email: 'admin@email.com', password: 'admin', first_name:'Bob', role: 1)

      expect(admin.role).to eq('admin')
      expect(admin.admin?).to be_truthy
    end
  end

  describe 'instance methods' do
    it '.show_bookmarked_tutorials' do
      user = create(:user)

      tutorial_1 = create(:tutorial, title: 'How to Tie Your Shoes')

      video_1 = create(:video, title: 'The Bunny Ears Technique', tutorial: tutorial_1, position: 2)
      video_2 = create(:video, title: "I don't know how to tie my shoes", tutorial: tutorial_1, position: 1)

      create(:user_video, user: user, video: video_1)
      create(:user_video, user: user, video: video_2)

      bookmarked = {
        {
          tutorial_1.id => tutorial_1.title
        } => [
          {
            video_2.id => video_2.title
          },
          {
            video_1.id => video_1.title
          }
        ]
      }

      expect(user.show_bookmarked_tutorials).to eq(bookmarked)
    end 
  end 
end
