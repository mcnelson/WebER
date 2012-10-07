class SessionsController < ApplicationController
  layout "smallcenter"

  before_filter :no_anonymous, except: :destroy

  def new
  end

  def create
    user = User.find_by_punet(params[:punet])

    if user and user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_back notice: "Hey, welcome back #{ user.punet }."
    else
      flash.now.alert = "Incorrect password, try again."
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Logged out successfully."
  end

  def no_anonymous
    redirect_back if current_user
  end
end
