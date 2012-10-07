class AdminController < ApplicationController
  layout 'admin'

  before_filter :check_permissions

  def check_permissions
    # Login if no user
    return redirect_to signin_path if current_user.nil?

    # Allow admin, workstudy to pass. This could be further restricted at the controller level
    return if current_user and ["admin", "workstudy"].include? current_user.permission_level
    # Kick out otherwise
    redirect_back
  end
end
