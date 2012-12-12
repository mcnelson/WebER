require 'spec_helper'
describe Admin::ReservationsController do

  before do
    signin_as("admin")
  end

  describe "POST create" do
    it 'creates a new reservation' do
      post :create, {}
      @reservation = FactoryGirl.create(:reservation_with_five_equipment)
      @reservation.shold be_persisted
    end
  end
end
