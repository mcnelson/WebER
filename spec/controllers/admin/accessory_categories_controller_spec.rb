require 'spec_helper'

describe Admin::AccessoryCategoriesController, type: :controller do
  render_views
  before { signin_as("admin") }

  describe '#edit' do
    let!(:accessory_category) { create(:accessory_category) }

    it 'it renders correct template' do
      get :edit, id: accessory_category
      expect(response).to render_template("edit")
      expect(response).to be_successful
    end
  end

  describe '#create' do
    it 'creates an equipment category' do
      post :create, accessory_category: attributes_for(:accessory_category)
      expect(response).to redirect_to(admin_categories_path)
      expect(assigns(:category)).to be_persisted
    end
  end

  describe '#update' do
    let!(:accessory_category) { create(:accessory_category, title: 'foo') }

    it 'updates an equipment category' do
      patch :update, id: accessory_category, accessory_category: attributes_for(:accessory_category, title: 'bar')
      expect(response).to redirect_to(admin_categories_path)
      expect(assigns(:category).title).to eql('bar')
    end
  end
end
