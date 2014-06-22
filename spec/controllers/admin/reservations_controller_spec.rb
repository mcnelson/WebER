require 'spec_helper'

describe Admin::ReservationsController do
  include SemestersSupport

  def valid_attributes
    @user = FactoryGirl.create(:user)
    FactoryGirl.attributes_for(:reservation).merge({ user_id: @user.id })
  end

  before do
    signin_as("admin")
    semester_with_test_er_hours
  end

  describe "POST create" do
    it 'creates a new reservation' do
      post :create, {reservation: valid_attributes}
      assigns(:reservation).should be_a(Reservation)
      assigns(:reservation).should be_persisted
    end
  end
end
