class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase

    if user&.authenticate(params[:session][:password])
      if user.activated?
        log_in user
        params[:session][:remember_me] == "1" ? remember(user) : forget(user)
        redirect_back_or user
      else
        message  = t "accountnotactivated"
        message += t "checkmailsmess"
        flash[:warning] = message
        redirect_to root_url
      end
    else
      flash.now[:danger] = t "buglogin"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private

  def check_box_remember user
    session_remember_me = params[:session][:remember_me]
    session_remember_me == Settings.boolean ? remember(user) : forget(user)
  end
end
