require 'spec_helper'

describe ReservationsController, type: :controller do
  include SemestersSupport
  render_views
  before { signin_as("student") }

  let(:reservation_with_one_unit) do
    build(:reservation).tap do |r|
      r.equipment << create(:equipment)
      r.user = controller.current_user
      r.save!
    end
  end

  pending '#index'

  describe '#show' do
    before { semester_with_test_er_hours }
    let!(:reservation) { reservation_with_one_unit }

    it 'shows the given reservation' do
      get :show, id: reservation_with_one_unit
      expect(response).to be_success
      expect(response).to render_template("show")
    end
  end

  describe '#new' do
    before { semester_with_test_er_hours }

    it 'renders the form with an empty reservation' do
      get :new
      expect(assigns(:reservation)).to be_a_new(Reservation)
      expect(response).to render_template("new")
    end
  end

  describe '#create' do
    context "HTML" do
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

    context "JS" do
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
        post :create, reservation: attrs, format: :js
        expect(assigns(:reservation)).to be_a(Reservation)
        expect(assigns(:reservation)).to be_persisted
      end
    end
  end
end
