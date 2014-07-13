
require 'spec_helper'

describe Admin::AccessoriesController, type: :controller do
  render_views
  before { signin_as("admin") }

  describe "#show" do
    let(:accessory) { create(:accessory) }

    it "assigns the requested accessory as @accessory" do
      get :show, {id: accessory}
      expect(assigns(:accessory)).to eql(accessory)
    end
  end

  describe "#new" do
    it "assigns a new accessory as @accessory" do
      get :new
      expect(assigns(:accessory)).to be_a_new(Accessory)
      expect(response).to render_template("new")
    end
  end

  describe "#edit" do
    let(:accessory) { create(:accessory) }

    it "assigns the requested accessory as @accessory" do
      get :edit, {id: accessory}
      expect(assigns(:accessory)).to eq(accessory)
      expect(response).to render_template("edit")
    end
  end

  describe "#create" do
    context "with valid params" do
      it "creates a new Accessory" do
        expect {
          post :create, {accessory: attributes_for(:accessory, category_id: 1)}
        }.to change(Accessory, :count).by(1)

        expect(assigns(:accessory)).to be_a(Accessory)
        expect(assigns(:accessory)).to be_persisted
        expect(response).to redirect_to([:admin, assigns(:accessory)])
        expect(flash[:success]).to be_present
      end
    end

    context "with invalid params" do
      let(:invalid_attrs) do
        attributes_for(:accessory, category_id: "")
      end

      it "assigns a newly created but unsaved accessory as @accessory" do
        post :create, accessory: invalid_attrs
        expect(assigns(:accessory)).to be_a_new(Accessory)
        expect(response).to render_template("new")
      end
    end
  end

  describe "#update" do
    let(:accessory) { create(:accessory) }

    context "with valid params" do
      it "updates the requested accessory" do
        put :update, {id: accessory, accessory: attributes_for(:accessory)}
        expect(assigns(:accessory)).to eql(accessory)
        expect(response).to redirect_to([:admin, accessory])
        expect(flash[:success]).to be_present
      end
    end

    describe "with invalid params" do
      it "assigns the accessory as @accessory" do
        put :update, {id: accessory, accessory: attributes_for(:accessory, category_id: "")}
        expect(assigns(:accessory)).to eql(accessory)
        expect(response).to render_template("edit")
      end
    end
  end

  describe "#destroy" do
    let!(:accessory) { create(:accessory) }

    it "destroys the requested accessory" do
      expect {
        delete :destroy, {id: accessory}
      }.to change(Accessory, :count).by(-1)

      expect(response).to redirect_to(admin_equipment_index_path)
    end
  end
end
