
require 'spec_helper'

describe AjaxController do
  include FallSemester

  describe '#reservation_tabbox' do
    pending "Unsure what this will ultimately do right now"
  end

  describe '#check_equipment_availability' do
    before do
      setup_fall_semester_and_er_hours

      @reservation_monday = FactoryGirl.create(:reservation,
        starts_at: Date.parse("Nov 26, 2012"), # Monday
        ends_at:   Date.parse("Nov 28, 2012") # Wednesday
      )

      @reservation_thursday = FactoryGirl.create(:reservation,
        starts_at: Date.parse("Nov 29, 2012"), # Thursday
        ends_at:   Date.parse("Dec 3, 2012") # Monday
      )

      @equipment = FactoryGirl.create(:equipment)
      FactoryGirl(:equipment_reservation, reservation: @reservation_monday, equipment: @equipment)
      FactoryGirl(:equipment_reservation, reservation: @reservation_thursday, equipment: @equipment)
    end

    context 'with a Tuesday to Thursday range' do
      before do
        @reservation_tuesday = FactoryGirl.create(:reservation,
          starts_at: Date.parse("Nov 27, 2012"), # Tuesday
          ends_at:   Date.parse("Nov 29, 2012") # Thursday
        )
        FactoryGirl.create(:equipment_reservation, reservation: @reservation_thursday, equipment: @equipment)
      end

      it 'is not available' do
        xhr :get, :check_equipment_availability,
          start_at:     @reservation_tuesday.starts_at,
          end_at:       @reservation_tuesday.ends_at,
          equipment_id: @equipment.id

        puts response.to_yaml
      end
    end
  end

  describe '#equipment_dependencies' do
    pending "Hat"
  end
end
