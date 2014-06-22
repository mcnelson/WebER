require 'spec_helper'

describe Admin::ReservationsController, type: :controller do
  include SemestersSupport
  before { signin_as("admin") }

  let(:reservation_with_one_unit) do
    build(:reservation).tap do |r|
      r.equipment << create(:equipment)
      r.save!
    end
  end

  describe "#index" do
    it "displays sortable/paginated reservations" do
      get :index
      expect(assigns(:reservations)).to include(reservation_with_one_unit)
    end
  end

  describe '#show' do
    it 'shows a reservation' do
      get :show, id: reservation_with_one_unit
      expect(response).to be_success
      expect(response).to render_template("show")
    end
  end

  describe '#new' do
    before { semester_with_test_er_hours }
    let(:user) { create(:user) }

    it 'renders the new form & populates an empty reservation' do
      get :new
      expect(assigns(:reservation)).to be_a_new(Reservation)
      expect(assigns(:reservation).user_id).to eql(controller.current_user.id)
    end
  end

  describe '#edit' do
    let(:user) { create(:user) }

    it 'renders the form with the loaded reservation' do
      get :edit, id: reservation_with_one_unit
      expect(response).to be_success
      expect(assigns(:reservation)).to eql(reservation_with_one_unit)
    end
  end

  describe "#create" do
    before { semester_with_test_er_hours }
    let(:user) { create(:user) }
    let(:equipment) { create(:equipment) }
    let(:attrs) do
      attributes_for(:reservation).merge(
        user_id: user.id,
        reserved_equipment_attributes: {"0" => {unit_id: equipment.id}},
      )
    end

    it 'creates a new reservation' do
      post :create, {reservation: attrs}
      expect(assigns(:reservation)).to be_a(Reservation)
      expect(assigns(:reservation)).to be_persisted
    end
  end

  describe '#update' do
    let(:current_reserved_unit) { reservation_with_one_unit.reserved_units.first }
    let(:new_equipment) { create(:equipment) }
    let(:attrs) do
      attributes_for(:reservation).merge(
        reserved_equipment_attributes: {
          #current_reserved_unit.id => {unit_id: current_reserved_unit.unit_id}, TODO: shouldn't this work?
          "0"                      => {unit_id: new_equipment.id},
        },
      )
    end

    it 'updates the given reservation' do
      put :update, id: reservation_with_one_unit, reservation: attrs
      reservation_with_one_unit.reload
      expect(reservation_with_one_unit.equipment_ids).to include(current_reserved_unit.unit_id)
      expect(reservation_with_one_unit.equipment_ids).to include(new_equipment.id)
    end
  end

  describe '#destroy' do
    it 'deletes the given reservation' do
      reservation_with_one_unit # create the object

      expect {
        delete :destroy, id: reservation_with_one_unit
      }.to change(Reservation, :count).by(-1)

      expect(response).to be_redirect
    end
  end
end
