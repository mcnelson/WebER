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

  describe '#index', integration: true do
    let(:time) { Time.new(2014, 1, 1, 14, 0, 0) }

    before do
      semester_with_test_er_hours
      Timecop.freeze(time)
    end
    after { Timecop.return }

    let!(:reservation) do
      build(:reservation).tap do |r|
        r.starts_at = (time + 1.day).change(hour: 13)
        r.ends_at = (time + 3.days).change(hour: 15)

        r.equipment << create(:equipment)
        r.accessories << create(:accessory)
        r.user = controller.current_user
        r.save!
      end
    end

    it 'shows due & all reservations' do
      get :index

      expect(response).to be_success
      expect(response).to render_template("index")

      # Check date formatting & counts
      expect(response.body).to include('1/2/2014  1:00pm')
      expect(response.body).to include('1/4/2014  3:00pm')
      expect(response.body).to include('1E')
      expect(response.body).to include('1A')
    end
  end

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
