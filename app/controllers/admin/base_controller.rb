class Admin::BaseController < ApplicationController
  before_action :require_admin

  def require_admin
    # four_oh_four unless current_user.admin?
    render file: 'public/404', status: 404 unless current_user.admin?
  end
end
