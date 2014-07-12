require 'spec_helper'

describe UnitsController, type: :controller do
  describe '#forty_image' do
    let(:equipment) { create(:equipment, photo: fixture_file_upload('hpx_test_photo.jpg', 'image/jpg')) }

    it "returns the 'forty' image size of the unit's photo" do
      get :forty_image, unit_id: equipment.id
      expect(response.body).to match(/.*\/+.*hpx_test_photo\.jpg.*/)
    end

    context "equipment not found" do
      it "renders a 404" do
        get :forty_image, unit_id: 857834
        expect(response).to be_not_found
      end
    end
  end
end
