class AdminController < ApplicationController
  layout 'admin'

  before_filter :require_workstudy

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
end
