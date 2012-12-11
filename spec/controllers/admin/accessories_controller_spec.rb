
require 'spec_helper'

describe Admin::AccessoriesController do
  def valid_attributes
    FactoryGirl.attributes_for(:accessory, category_id: @accessory_category)
  end

  before do
    signin_as("admin")
    @accessory_category = FactoryGirl.create(:accessory_category)
  end

  describe "GET show" do
    it "assigns the requested accessory as @accessory" do
      accessory = Accessory.create! valid_attributes
      get :show, {:id => accessory.to_param}
      assigns(:accessory).should eq(accessory)
    end
  end

  describe "GET new" do
    it "assigns a new accessory as @accessory" do
      get :new, {}
      assigns(:accessory).should be_a_new(Accessory)
    end
  end

  describe "GET edit" do
    it "assigns the requested accessory as @accessory" do
      accessory = Accessory.create! valid_attributes
      get :edit, {:id => accessory.to_param}
      assigns(:accessory).should eq(accessory)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Accessory" do
        expect {
          post :create, {:accessory => valid_attributes}
        }.to change(Accessory, :count).by(1)
      end

      it "assigns a newly created accessory as @accessory" do
        post :create, {:accessory => valid_attributes}
        assigns(:accessory).should be_a(Accessory)
        assigns(:accessory).should be_persisted
      end

      it "redirects to the created accessory" do
        post :create, {:accessory => valid_attributes}
        response.should redirect_to([:admin, Accessory.last])
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved accessory as @accessory" do
        # Trigger the behavior that occurs when invalid params are submitted
        Accessory.any_instance.stub(:save).and_return(false)
        post :create, {:accessory => {}}
        assigns(:accessory).should be_a_new(Accessory)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Accessory.any_instance.stub(:save).and_return(false)
        post :create, {:accessory => {}}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested accessory" do
        accessory = Accessory.create! valid_attributes
        # Assuming there are no other accessory in the database, this
        # specifies that the Accessory created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Accessory.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => accessory.to_param, :accessory => {'these' => 'params'}}
      end

      it "assigns the requested accessory as @accessory" do
        accessory = Accessory.create! valid_attributes
        put :update, {:id => accessory.to_param, :accessory => valid_attributes}
        assigns(:accessory).should eq(accessory)
      end

      it "redirects to the accessory" do
        accessory = Accessory.create! valid_attributes
        put :update, {:id => accessory.to_param, :accessory => valid_attributes}
        response.should redirect_to([:admin, accessory])
      end
    end

    describe "with invalid params" do
      it "assigns the accessory as @accessory" do
        accessory = Accessory.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Accessory.any_instance.stub(:save).and_return(false)
        put :update, {:id => accessory.to_param, :accessory => {}}
        assigns(:accessory).should eq(accessory)
      end

      it "re-renders the 'edit' template" do
        accessory = Accessory.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Accessory.any_instance.stub(:save).and_return(false)
        put :update, {:id => accessory.to_param, :accessory => {}}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested accessory" do
      accessory = Accessory.create! valid_attributes
      expect {
        delete :destroy, {:id => accessory.to_param}
      }.to change(Accessory, :count).by(-1)
    end

    it "redirects to the categories index" do
      accessory = Accessory.create! valid_attributes
      delete :destroy, {:id => accessory.to_param}
      response.should redirect_to(admin_equipment_index_path)
    end
  end
end
