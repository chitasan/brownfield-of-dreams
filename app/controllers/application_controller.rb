# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :current_user,
                :find_bookmark,
                :list_tags,
                :tutorial_name,
                :current_admin?

  add_flash_types :success

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def find_bookmark(id)
    current_user.user_videos.find_by(video_id: id)
  end

  def tutorial_name(id)
    Tutorial.find(id).title
  end

  def current_admin?
    current_user&.admin?
  end
end
