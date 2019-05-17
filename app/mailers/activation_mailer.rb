class ActivationMailer < ApplicationMailer
  def account_activation(user)
    @user = user
    mail to: @user.email, subject: 'Account Activation - Brownfield of Dreams'
  end
end