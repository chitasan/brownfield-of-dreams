require 'rails_helper'

describe "Friendship API" do
  describe "sends a hash of two user ids" do
    it "so that the SOA - friends can create a friendship object" do
      jen = User.create(email: "jennica.stiehl@gmail.com", first_name: "Jennica", last_name: "Stiehl", password: "password", role: "default", created_at: "2019-05-07 13:37:54", updated_at: "2019-05-09 20:46:46", token: ENV['JENNICA_USER_TOKEN'] )
      chi = User.create(email: "chidtran@gmail.com", first_name: "chi", last_name: "tran", password: "test", role: "default", created_at: "2019-05-09 14:03:07", updated_at: "2019-05-09 20:57:01", token: ENV['CHI_USER_TOKEN'] )

      get "/api/v1/users/#{jen.id}/friends/#{chi.id}"

      expect(response).to be_successful
      user_friend = JSON.parse(response.body, symbolize_names: true)
      # binding.pry
      expect(user_friend[:id].to_i).to eq(jen.id)
      expect(user_friend[:recipient_id].to_i).to eq(chi.id)
    end
  end
end
