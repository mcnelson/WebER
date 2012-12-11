module Sessions
  def signin_as_admin
    test_user = FactoryGirl.create(:user, permission_level: "admin")
    session[:user_id] = test_user.id
  end
end

