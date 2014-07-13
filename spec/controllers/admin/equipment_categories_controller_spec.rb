require 'spec_helper'

describe Admin::EquipmentCategoriesController, type: :controller do
  render_views
  before { signin_as("admin") }

  describe '#edit' do
    let!(:equipment_category) { create(:equipment_category) }

    it 'it renders correct template' do
      get :edit, id: equipment_category
      expect(response).to render_template("edit")
      expect(response).to be_successful
    end
  end

  describe '#create' do
    it 'creates an equipment category' do
      post :create, equipment_category: attributes_for(:equipment_category)
      expect(response).to redirect_to(admin_categories_path)
      expect(assigns(:category)).to be_persisted
      expect(flash[:success]).to be_present
    end
  end

  describe '#update' do
    let!(:equipment_category) { create(:equipment_category, title: 'foo') }

    it 'updates an equipment category' do
      patch :update, id: equipment_category, equipment_category: attributes_for(:equipment_category, title: 'bar')
      expect(response).to redirect_to(admin_categories_path)
      expect(assigns(:category).title).to eql('bar')
      expect(flash[:success]).to be_present
    end
  end
end
