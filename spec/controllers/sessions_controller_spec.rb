require 'spec_helper'

describe SessionsController do
  context 'with a valid user session' do
    before do
      u = Factory(:user)
      session[:user_id] = u.id
    end

    it "redirects " do
      get :index
      it {should_not redirect_to(signin_path)
    end
  end

  context 'with a nil user session' do
    before do
      u = Factory(:user)
      session[:user_id] = nil
    end

    it "redirects to the sign-in page" do
      .should redirect_to(signin_path)
    end
  end
end
