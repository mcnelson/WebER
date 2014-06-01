module SessionSupport
  def signin_as(permission_level)
    test_user = FactoryGirl.create(:user, permission_level: permission_level)
    session[:user_id] = test_user.id
  end
end
