class SessionsController < ApplicationController
  layout "smallcenter"
  before_filter :anonymous_only, except: :destroy

  def create
    user = User.find_by_punet(params[:punet])

    if user && user.authenticate(params[:password])
      if user.active
        session[:user_id] = user.id
        redirect_to '/', flash: {success: "Welcome back, #{user.punet}!"}
      else
        render "unavailable_account", layout: "smallcenter"
      end

    else
      flash.now.alert = "That username & password combo doesn't match any of our records. Try again."
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, flash: {success: "Logged out successfully."}
  end

  def anonymous_only
    redirect_to root_url if current_user.present?
  end
end
