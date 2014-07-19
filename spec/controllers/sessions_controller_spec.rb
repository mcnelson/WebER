require 'spec_helper'

describe SessionsController, type: :controller do
  render_views

  describe "#new" do
    context 'happy path' do
      it "renders login form" do
        get :new
        expect(response).to be_successful
        expect(response).to render_template("new")
      end
    end

    context 'already logged in' do
      before { signin_as("student") }

      it "redirects to /" do
        get :new
        expect(response).to redirect_to(root_url)
      end
    end
  end

  describe "#create" do
    let(:user) { create(:user, password: "herp derps", password_confirmation: "herp derps") }

    it "accepts correct login information" do
      post :create, {punet: user.punet, password: "herp derps"}

      expect(flash[:success]).to match(/welcome back/i)
      expect(flash[:alert]).to be_blank
      expect(response).to be_redirect
    end

    it "rejects incorrect username" do
      post :create, {punet: "nobody"}
      expect(flash[:alert]).to match(/doesn't match any of our records/i)
    end

    it "rejects incorrect password" do
      post :create, {punet: user.punet, password: "not herp derps"}
      expect(flash[:alert]).to match(/doesn't match any of our records/i)
    end

    context "inactive user" do
      let(:user) do
        create(:user,
          password:              "herp derps",
          password_confirmation: "herp derps",
          active:                false
        )
      end

      it "renders a small center message" do
        post :create, {punet: user.punet, password: "herp derps"}
        expect(response).to render_template("smallcenter")
        expect(response.body).to include("unavailable")
      end
    end
  end

  describe '#destroy' do
    before { signin_as("student") }

    it "logs user out" do
      delete :destroy

      expect(flash[:success]).to match(/logged out/i)
      expect(response).to redirect_to(root_url)
    end
  end
end
