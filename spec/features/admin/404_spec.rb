require 'rails_helper'
describe "as a user" do
  it "sees a 404 error when trying to access admin pages" do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit '/admin/dashboard'
    expect(page).to have_content('404')
  end
end
describe "as a visitor" do
  it "sees a 404 error when trying to access admin pages" do
    visit '/admin/dashboard'
    expect(page).to have_content('404')
  end
end
