class Api::V1::Users::FriendsController < ApplicationController
  def show
    data = Hash.new(0)
    data["id"] = params[:id]
    data["recipient_id"] = params[:recipient_id]
    render json: data
  end
end
