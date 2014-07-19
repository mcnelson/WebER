class ApplicationController < ActionController::Base
  helper_method :current_user, :sort_column, :sort_direction, :in_admin_area?
  before_filter :check_session_expiry

  protect_from_forgery

  def require_student
    # Login if no user
    return redirect_to signin_path if current_user.nil?
    return if current_user.student?

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

  def require_current_semester
    render_no_current_semester if Semester.current.nil?
  end

  def in_admin_area?
    self.class.superclass == AdminController
  end

  def sort_column
    params[:sort] || "id"
  end

  def sort_direction
    params[:direction] || "desc"
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def check_session_expiry
    return unless session[:user_id]

    if session[:expires_at].kind_of?(Time) && session[:expires_at] <= Time.now
      session[:user_id] = nil
      redirect_to signin_path,
        flash: {alert: "For security reasons, your session is no longer active."}

    else
      session[:expires_at] = 5.minutes.from_now
    end
  end

  private

  def redirect_back(opts={})
    return if root_url == request_url # Never redirect at root
    redirect_to((request.referer.present? and request.referer != request_url) ? request.referer : root_url, opts)
  end

  # http://stackoverflow.com/questions/2165665/how-do-i-get-the-current-url-in-ruby-on-rails
  def request_url
    "http://#{request.host}:#{request.port}#{request.fullpath}"
  end

  def render_403
    render file: "public/403", format: :html, status: 403, layout: nil
  end

  def render_404
    render file: "public/404", format: :html, status: 404, layout: nil
  end

  def render_no_current_semester
    render "no_current_semester", status: 500, layout: "smallcenter"
  end
end
