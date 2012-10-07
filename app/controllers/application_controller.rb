class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def redirect_back(opts={})
    return if root_url == request_url # Never redirect at root
    redirect_to((request.referer.present? and request.referer != request_url) ? request.referer : root_url, opts)
  end

  # http://stackoverflow.com/questions/2165665/how-do-i-get-the-current-url-in-ruby-on-rails
  def request_url
    "http://#{request.host}:#{request.port}#{request.fullpath}"
  end

  helper_method :current_user
end
