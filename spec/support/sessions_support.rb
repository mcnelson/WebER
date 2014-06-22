module SessionsSupport
  def signin_as(permission_level)
    permission_level = User::PERMISSION_LEVELS.index(permission_level) if permission_level.is_a?(String)
    test_user = FactoryGirl.create(:user, permission_level: permission_level)
    session[:user_id] = test_user.id
  end
end
