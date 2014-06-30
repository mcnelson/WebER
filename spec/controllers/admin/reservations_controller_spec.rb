require 'spec_helper'

describe Admin::ReservationsController, type: :controller do
  include SemestersSupport
  before { signin_as("admin") }
  render_views

  let(:reservation_with_one_unit) do
    build(:reservation).tap do |r|
      r.equipment << create(:equipment)
      r.save!
    end
  end

  describe "#index" do
    it "displays sortable/paginated reservations" do
      semester_with_test_er_hours
      reservation_with_one_unit

      get :index
      expect(assigns(:reservations)).to include(reservation_with_one_unit)
    end
  end

  describe '#show' do
    it 'shows a reservation' do
      semester_with_test_er_hours
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
    context 'happy path' do
      let(:user) { create(:user) }
      before { semester_with_test_er_hours }

      it 'renders the form with the loaded reservation' do
        get :edit, id: reservation_with_one_unit
        expect(response).to be_success
        expect(assigns(:reservation)).to eql(reservation_with_one_unit)
      end
    end

    context "no semester defined for the given reservation's dates" do
      it 'raises an error' do
        reservation_with_one_unit

        expect {
          get :edit, id: reservation_with_one_unit
        }.to raise_error(Reservation::SemesterMissingError)
      end
    end
  end

  describe "#create" do
    context "HTML" do
      before { semester_with_test_er_hours }
      let(:user) { create(:user) }
      let(:equipment) { create(:equipment) }
      let(:accessory) { create(:accessory) }
      let(:attrs) do
        attributes_for(:reservation).merge(
          user_id: user.id,
          reserved_equipment_attributes: {"0" => {unit_id: equipment.id}},
          reserved_accessories_attributes: {"0" => {unit_id: accessory.id}},
        )
      end

      it 'creates a new reservation' do
        post :create, {reservation: attrs}

        reservation = assigns(:reservation)
        expect(reservation).to be_a(Reservation)
        expect(reservation).to be_persisted
        expect(reservation.equipment).to include(equipment)
        expect(reservation.accessories).to include(accessory)
      end
    end

    context "JS" do
      before { semester_with_test_er_hours }
      let(:user) { create(:user) }
      let(:equipment) { create(:equipment) }
      let(:accessory) { create(:accessory) }
      let(:attrs) do
        attributes_for(:reservation).merge(
          user_id: user.id,
          reserved_equipment_attributes: {"0" => {unit_id: equipment.id}},
          reserved_accessories_attributes: {"0" => {unit_id: accessory.id}},
        )
      end

      it 'creates a new reservation' do
        post :create, reservation: attrs, format: :js

        reservation = assigns(:reservation)
        expect(reservation).to be_a(Reservation)
        expect(reservation).to be_persisted
        expect(reservation.equipment).to include(equipment)
        expect(reservation.accessories).to include(accessory)
      end
    end
  end

  describe '#update' do
    context "HTML" do
      let(:current_reserved_unit) { reservation_with_one_unit.reserved_units.first }
      let(:new_equipment) { create(:equipment) }
      let(:new_accessory) { create(:accessory) }
      let(:attrs) do
        attributes_for(:reservation).merge(
          # datepicker uses YMD format
          starts_at: I18n.localize(reservation_with_one_unit.starts_at, format: :ymd),
          ends_at:   I18n.localize(reservation_with_one_unit.ends_at, format: :ymd),

          reserved_equipment_attributes: {
            "0" => {id: current_reserved_unit.id, unit_id: current_reserved_unit.unit_id},
            "1" => {unit_id: new_equipment.id},
          },

          reserved_accessories_attributes: {
            "0" => {unit_id: new_accessory.id},
          },
        )
      end
      before { semester_with_test_er_hours }

      it 'updates the given reservation' do
        patch :update, id: reservation_with_one_unit, reservation: attrs
        reservation = assigns(:reservation)
        expect(reservation.equipment_ids).to include(current_reserved_unit.unit_id)
        expect(reservation.equipment_ids).to include(new_equipment.id)
      end
    end

    context "JS" do
      let(:current_reserved_unit) { reservation_with_one_unit.reserved_units.first }
      let(:new_equipment) { create(:equipment) }
      let(:new_accessory) { create(:accessory) }
      let(:attrs) do
        attributes_for(:reservation).merge(
          # datepicker uses YMD format
          starts_at: I18n.localize(reservation_with_one_unit.starts_at, format: :ymd),
          ends_at:   I18n.localize(reservation_with_one_unit.ends_at, format: :ymd),

          reserved_equipment_attributes: {
            "0" => {id: current_reserved_unit.id, unit_id: current_reserved_unit.unit_id},
            "1" => {unit_id: new_equipment.id},
          },

          reserved_accessories_attributes: {
            "0" => {unit_id: new_accessory.id},
          },
        )
      end
      before { semester_with_test_er_hours }

      it 'updates the given reservation' do
        patch :update, id: reservation_with_one_unit, reservation: attrs, format: :js
        reservation = assigns(:reservation)
        expect(reservation.equipment_ids).to include(current_reserved_unit.unit_id)
        expect(reservation.equipment_ids).to include(new_equipment.id)
      end
    end
  end

  describe '#destroy' do
    it 'deletes the given reservation' do
      semester_with_test_er_hours
      reservation_with_one_unit # create the object

      expect {
        delete :destroy, id: reservation_with_one_unit
      }.to change(Reservation, :count).by(-1)

      expect(response).to be_redirect
    end
  end
end
