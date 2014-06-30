require 'spec_helper'

describe Admin::CategoriesController, type: :controller do
  render_views
  before { signin_as("admin") }

  describe "#index" do
    let!(:equipment_category) { create(:equipment_category) }
    let!(:accessory_category) { create(:accessory_category) }

    it "assigns all equipment categories as @equipment_categories" do
      get :index
      expect(assigns(:equipment_categories)).to include(equipment_category)
      expect(assigns(:accessory_categories)).to include(accessory_category)
    end
  end

  describe "#destroy" do
    let!(:category) { create(:equipment_category) }

    it "destroys the requested category" do
      expect {
        delete :destroy, {id: category.to_param}
      }.to change(Category, :count).by(-1)

      expect(response).to redirect_to(admin_categories_path)
    end
  end

end
