
require 'spec_helper'

describe Admin::CategoriesController do
  def valid_attributes
    FactoryGirl.attributes_for(:equipment_category)
  end

  before do
    signin_as("admin")
  end

  describe "GET index" do
    it "assigns all equipment categories as @equipment_categories" do
      equipment_category = EquipmentCategory.create! valid_attributes
      get :index, {}
      assigns(:equipment_categories).should eq([equipment_category])
    end

    it "assigns all accessory categories as @accessory_categories" do
      accessory_category = AccessoryCategory.create! valid_attributes
      get :index, {}
      assigns(:accessory_categories).should eq([accessory_category])
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested category" do
      category = Category.create! valid_attributes
      expect {
        delete :destroy, {:id => category.to_param}
      }.to change(Category, :count).by(-1)
    end

    it "redirects to the categories index" do
      category = Category.create! valid_attributes
      delete :destroy, {:id => category.to_param}
      response.should redirect_to(admin_categories_path)
    end
  end

end
