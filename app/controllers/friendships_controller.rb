class FriendshipsController < ApplicationController
  def create
    Faraday.post("#{ENV["FRIENDSHIP_SITE"]}/api/v1/friendships?initiator_id=params[:initiator_id]&recipient_id=params[:recipient_id]")
    #https://still-headland-29350.herokuapp.com
    redirect_to dashboard_path
  end
end