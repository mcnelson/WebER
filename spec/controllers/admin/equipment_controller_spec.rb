require 'spec_helper'

describe Admin::EquipmentController, type: :controller do
  render_views
  before { signin_as("admin") }

  describe "#index" do
    let!(:equipment) { create(:equipment) }

    it "assigns all equipment as @equipment" do
      get :index
      expect(assigns(:equipment)).to include(equipment)
    end
  end

  describe "#show" do
    let!(:equipment) { create(:equipment) }

    it "assigns the requested equipment as @equipment" do
      get :show, {id: equipment}
      expect(assigns(:equipment)).to eq(equipment)
    end
  end

  describe "#new" do
    it "assigns a new equipment as @equipment" do
      get :new
      expect(assigns(:equipment)).to be_a_new(Equipment)
    end
  end

  describe "#edit" do
    let!(:equipment) { create(:equipment) }

    it "assigns the requested equipment as @equipment" do
      get :edit, {id: equipment}
      expect(assigns(:equipment)).to eql(equipment)
    end
  end

  describe "#create" do
    context "with valid params" do
      it "creates a new Equipment" do
        expect {
          post :create, {equipment: attributes_for(:equipment,
            category_id: 1,
            photo: fixture_file_upload('hpx_test_photo.jpg', 'image/jpg')
          )}
        }.to change(Equipment, :count).by(1)

        expect(assigns(:equipment)).to be_a(Equipment)
        expect(assigns(:equipment)).to be_persisted
        expect(response).to redirect_to([:admin, Equipment.last])
        expect(flash[:success]).to be_present
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved equipment as @equipment" do
        post :create, equipment: attributes_for(:equipment, name: "")
        expect(assigns(:equipment)).to be_a_new(Equipment)
        expect(response).to render_template("new")
      end
    end
  end

  describe "#update" do
    let(:equipment) { create(:equipment) }

    context "with valid params" do
      it "updates the requested equipment" do
        put :update, id: equipment, equipment: attributes_for(:equipment, category_id: 1)
        expect(assigns(:equipment)).to eq(equipment)
        expect(response).to redirect_to([:admin, equipment])
        expect(flash[:success]).to be_present
      end
    end

    context "with invalid params" do
      it "assigns the equipment as @equipment" do
        put :update, id: equipment, equipment: attributes_for(:equipment, name: "")
        expect(assigns(:equipment)).to eq(equipment)
        expect(response).to render_template("edit")
      end
    end
  end

  describe "#destroy" do
    let!(:equipment) { create(:equipment) }

    it "destroys the requested equipment" do
      expect {
        delete :destroy, {id: equipment}
      }.to change(Equipment, :count).by(-1)
      expect(response).to redirect_to(admin_equipment_index_path)
    end
  end
end
