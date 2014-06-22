require 'spec_helper'

describe Admin::ReservationsController, type: :controller do
  include SemestersSupport

  let!(:current_semester) { semester_with_test_er_hours }
  before { signin_as("admin") }

  describe "#create" do
    let(:reservation_owner) { create(:user) }
    let(:equipment) { create(:equipment) }
    let(:attrs) do
      attributes_for(:reservation).merge(
        user_id: reservation_owner.id,
        reserved_equipment_attributes: [equipment.id],
      )
    end

    it 'creates a new reservation' do
      post :create, {reservation: attrs}
      expect(assigns(:reservation)).to be_a(Reservation)
      expect(assigns(:reservation)).to be_persisted
    end
  end
end
