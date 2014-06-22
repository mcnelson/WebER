require 'spec_helper'

describe Admin::ReservationsController, type: :controller do
  include SemestersSupport
  before { signin_as("admin") }

  describe "#index" do
    let!(:reservation) do
      build(:reservation).tap do |r|
        r.equipment << create(:equipment)
        r.save!
      end
    end

    it "displays sortable/paginated reservations" do
      get :index
      expect(assigns(:reservations)).to include(reservation)
    end
  end

  describe "#create" do
    let!(:current_semester) { semester_with_test_er_hours }
    let(:reservation_owner) { create(:user) }
    let(:equipment) { create(:equipment) }
    let(:attrs) do
      attributes_for(:reservation).merge(
        user_id: reservation_owner.id,
        reserved_equipment_attributes: {"0" => {unit_id: equipment.id}},
      )
    end

    it 'creates a new reservation' do
      post :create, {reservation: attrs}
      expect(assigns(:reservation)).to be_a(Reservation)
      expect(assigns(:reservation)).to be_persisted
    end
  end
end
