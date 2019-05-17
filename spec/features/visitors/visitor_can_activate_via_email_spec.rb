require 'rails_helper'

RSpec.describe 'visitor' do
  describe 'after successfully creating an account' do
    xit 'sees a message to activate account' do
      email = 'jimbob@aol.com'
      first_name = 'Jim'
      last_name = 'Bob'
      password = 'password'
      
      visit '/'
      click_on 'Register'
      
      expect(current_path).to eq('/register')

      fill_in 'user[email]', with: email
      fill_in 'user[first_name]', with: first_name
      fill_in 'user[last_name]', with: last_name
      fill_in 'user[password]', with: password
      fill_in 'user[password_confirmation]', with: password

      click_on 'Create Account'
      
      user = User.last

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      expect(current_path).to eq(dashboard_path)

      expect(page).to have_content('This account has not yet been activated. Please check your email.')
      expect(User.last.activated).to eq(false)
      expect(User.last.activation_token).to_not be_nil
    end

    xit 'can click on the link in the activation email to activate their account' do
      user = User.create!(email: 'jimbob@aol.com', password: 'password', first_name: 'Jim', last_name: 'Bob')

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit activations_path(token: user.activation_token)
      
      expect(page).to have_content('Thank you! Your account is now activated.')
      
      visit dashboard_path
      
      expect(page).to have_content('Status: Active')
    end

    it 'cannot register if email is already in use' do
      create(:user, email: 'jimbob@aol.com')
      
      email = 'jimbob@aol.com'
      first_name = 'Jim'
      last_name = 'Bob'
      password = 'password'

      visit '/'

      click_on 'Register'
      
      expect(current_path).to eq('/register')

      fill_in 'user[email]', with: email
      fill_in 'user[first_name]', with: first_name
      fill_in 'user[last_name]', with: last_name
      fill_in 'user[password]', with: password
      fill_in 'user[password_confirmation]', with: password
      click_on 'Create Account'
      
      expect(page).to have_content('Username already exists')
    end
  end
end