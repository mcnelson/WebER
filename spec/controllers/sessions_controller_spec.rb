require 'spec_helper'

describe SessionsController do
  context 'user is already logged in' do
    before { signin_as("student") }

    describe "#new" do
      it "redirects" do
        get :new
        expect(response).to redirect_to(root_url)
      end
    end
  end

  context 'with a nil user session' do
    before do
      @plaintext_password = "rawrz"
      @user = FactoryGirl.create(:user, password: @plaintext_password, password_confirmation: @plaintext_password)
      session[:user_id] = nil
    end

    describe "GET new" do
      it "does not redirect" do
        get :new, {}
        response.should_not redirect_to(root_url)
      end
    end

    describe "POST create" do
      it "rejects incorrect login information" do
        post :create, { punet: @user.punet, password: "notcorrect" }
        flash[:alert].should =~ /incorrect password/i
      end

      it "accepts correct login information" do
        post :create, { punet: @user.punet, password: @plaintext_password }
        flash[:notice].should =~ /welcome back/i
        flash[:alert].should be_blank
        response.should be_redirect
      end
    end
  end
end
