require 'spec_helper'
describe Admin::ReservationsController do
  def valid_attributes
    @user = FactoryGirl.create(:user)
    FactoryGirl.attributes_for(:reservation).merge({ user_id: @user.id })
  end

  before do
    signin_as("admin")
  end

  describe "POST create" do
    it 'creates a new reservation' do
      post :create, { reservation: valid_attributes }
      assigns(:reservation).should be_a(Reservation)
      assigns(:reservation).should be_persisted
    end
  end
end
