class SessionsController < ApplicationController
  def new

  end

  def create
    user = User.find_by_punet(params[:punet])

    if user and user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_url, notice: "Hey, welcome back #{ user.punet }."
    else
      flash.now.alert = "Incorrect password, try again."
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Logged out successfully."
  end
end
