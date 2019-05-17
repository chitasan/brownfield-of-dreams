class UsersController < ApplicationController
  def show
    render locals: { 
      facade: UserDashboardFacade.new(current_user), bookmarked_tutorials: current_user.show_bookmarked_tutorials }
  end

  def new
    @user = User.new
  end

  def create
    if user.save
      create_user
    else
      error
    end
  end

  def update
    current_user.update(uid: user_info.uid, token: user_info.credentials.token)

    redirect_to dashboard_path
  end

  private

  def user
    @user ||= User.create(user_params)
  end

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password, :password_confirmation)
  end

  def user_info
    request.env['omniauth.auth']
  end

  def create_user
    user = User.create(user_params)
    session[:user_id] = user.id
    flash[:success] = "Logged in as #{user.first_name}"
    flash[:notice] = 'This account has not yet been activated. Please check your email.'

    ActivationMailer.account_activation(current_user).deliver_now

    redirect_to dashboard_path
  end

  def error
    flash[:error] = 'Username already exists'
    @user = user
    
    render :new
  end
end
