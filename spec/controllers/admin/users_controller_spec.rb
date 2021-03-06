require 'spec_helper'

describe Admin::UsersController, type: :controller do
  render_views
  before { signin_as("admin") }

  describe "#index" do
    it "lists users" do
      user = create(:user)
      inactive_user = create(:user, active: false)

      get :index
      expect(response).to be_successful
      expect(assigns(:users)).to include(user)
      expect(assigns(:users)).not_to include(inactive_user)
    end

    it "can show inactive users" do
      user = create(:user)
      inactive_user = create(:user, active: false)

      get :index, show_inactive: "On"
      expect(response).to be_successful
      expect(assigns(:users)).to include(user)
      expect(assigns(:users)).to include(inactive_user)
    end
  end

  describe "#new" do
    it "renders the form" do
      get :new
      expect(response).to render_template("new")
      expect(assigns(:user)).to be_a_new(User)
    end
  end

  describe "#edit" do
    it "assigns the requested user as @user" do
      user = create(:user)
      get :edit, {id: user}
      expect(response).to render_template("edit")
      expect(assigns(:user)).to eql(user)
    end
  end

  describe "#create" do
    describe "with valid params" do
      it "creates a new User" do
        expect {
          post :create, {user: attributes_for(:user)}
        }.to change(User, :count).by(1)

        expect(assigns(:user)).to be_a(User)
        expect(assigns(:user)).to be_persisted
        expect(response).to redirect_to(edit_admin_user_path(User.last))
        expect(flash[:success]).to be_present
      end
    end

    describe "with invalid params" do
      let(:invalid_attrs) do
        attributes_for(:user).tap { |a| a[:punet] = "" }
      end

      it "rerenders the form with errors" do
        post :create, {user: invalid_attrs}

        expect(assigns(:user)).to be_a_new(User)
        expect(response).to render_template("new")
      end
    end
  end

  describe "#update" do
    let(:user) { create(:user) }

    context "valid params" do
      let(:valid_attrs_without_password) do
        attributes_for(:user).tap do |p|
          p[:password] = ""
          p[:password_confirmation] = ""
        end
      end

      it "updates the requested user" do
        put :update, {id: user, user: valid_attrs_without_password}
        expect(response).to redirect_to(edit_admin_user_path(User.last))
        expect(flash[:success]).to be_present
      end
    end

    context "valid params with password" do
      it "updates the requested user" do
        put :update, {id: user, user: attributes_for(:user)}
        expect(response).to redirect_to(edit_admin_user_path(User.last))
      end
    end

    context "invalid params" do
      let(:invalid_attrs) do
        attributes_for(:user).tap do |p|
          p[:punet] = ""
        end
      end

      it "assigns the user as @user" do
        put :update, {id: user, user: invalid_attrs}
        expect(response).to render_template("edit")
      end
    end
  end
end
