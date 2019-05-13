class UsersController < ApplicationController
  def show
    render locals: { facade: UserDashboardFacade.new(current_user)}
  end

  def new
    @user = User.new
  end

  def create
    user = User.create(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to dashboard_path
    else
      flash[:error] = 'Username already exists'
      render :new
    end
  end

  def update
    current_user.update(uid: user_info.uid, token: user_info.credentials.token)

    redirect_to dashboard_path
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end

  def user_info
    request.env['omniauth.auth']
  end 
end
