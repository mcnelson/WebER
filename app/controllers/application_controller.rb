class ApplicationController < ActionController::Base
  protect_from_forgery

  def require_student
    # Login if no user
    return redirect_to signin_path if current_user.nil?
    return if current_user.workstudy?

    # Kick out otherwise
    render_403
  end

  def require_workstudy
    # Login if no user
    return redirect_to signin_path if current_user.nil?
    return if current_user.workstudy?

    # Kick out otherwise
    render_403
  end

  def require_admin
    return redirect_to signin_path if current_user.nil?
    return if current_user.admin?

    render_403
  end

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

  def render_403
    render file: "public/403", format: :html, status: 404, layout: nil
  end

  helper_method :current_user
end
