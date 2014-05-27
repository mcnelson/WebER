
require 'spec_helper'

describe Admin::EquipmentController do
  def valid_attributes
    FactoryGirl.attributes_for(:equipment).merge(category_id: @equipment_category.id)
  end

  before do
    signin_as("admin")
    @equipment_category = FactoryGirl.create(:equipment_category)
  end

  describe "GET index" do
    it "assigns all equipment as @equipment" do
      equipment = Equipment.create! valid_attributes
      get :index, {}
      assigns(:equipment).should eq([equipment])
    end
  end

  describe "GET show" do
    it "assigns the requested equipment as @equipment" do
      equipment = Equipment.create! valid_attributes
      get :show, {:id => equipment.to_param}
      assigns(:equipment).should eq(equipment)
    end
  end

  describe "GET new" do
    it "assigns a new equipment as @equipment" do
      get :new, {}
      assigns(:equipment).should be_a_new(Equipment)
    end
  end

  describe "GET edit" do
    it "assigns the requested equipment as @equipment" do
      equipment = Equipment.create! valid_attributes
      get :edit, {:id => equipment.to_param}
      assigns(:equipment).should eq(equipment)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Equipment" do
        expect {
          post :create, {:equipment => valid_attributes}
        }.to change(Equipment, :count).by(1)
      end

      it "assigns a newly created equipment as @equipment" do
        post :create, {:equipment => valid_attributes}
        assigns(:equipment).should be_a(Equipment)
        assigns(:equipment).should be_persisted
      end

      it "redirects to the created equipment" do
        post :create, {:equipment => valid_attributes}
        response.should redirect_to([:admin, Equipment.last])
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved equipment as @equipment" do
        # Trigger the behavior that occurs when invalid params are submitted
        Equipment.any_instance.stub(:save).and_return(false)
        post :create, {:equipment => {}}
        assigns(:equipment).should be_a_new(Equipment)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Equipment.any_instance.stub(:save).and_return(false)
        post :create, {:equipment => {}}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested equipment" do
        equipment = Equipment.create! valid_attributes
        # Assuming there are no other equipment in the database, this
        # specifies that the Equipment created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Equipment.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => equipment.to_param, :equipment => {'these' => 'params'}}
      end

      it "assigns the requested equipment as @equipment" do
        equipment = Equipment.create! valid_attributes
        put :update, {:id => equipment.to_param, :equipment => valid_attributes}
        assigns(:equipment).should eq(equipment)
      end

      it "redirects to the equipment" do
        equipment = Equipment.create! valid_attributes
        put :update, {:id => equipment.to_param, :equipment => valid_attributes}
        response.should redirect_to([:admin, equipment])
      end
    end

    describe "with invalid params" do
      it "assigns the equipment as @equipment" do
        equipment = Equipment.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Equipment.any_instance.stub(:save).and_return(false)
        put :update, {:id => equipment.to_param, :equipment => {}}
        assigns(:equipment).should eq(equipment)
      end

      it "re-renders the 'edit' template" do
        equipment = Equipment.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Equipment.any_instance.stub(:save).and_return(false)
        put :update, {:id => equipment.to_param, :equipment => {}}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested equipment" do
      equipment = Equipment.create!(valid_attributes)
      expect {
        delete :destroy, {:id => equipment.to_param}
      }.to change(Equipment, :count).by(-1)
    end

    it "redirects to the equipment list" do
      equipment = Equipment.create! valid_attributes
      delete :destroy, {:id => equipment.to_param}
      response.should redirect_to(admin_equipment_index_path)
    end
  end

end
