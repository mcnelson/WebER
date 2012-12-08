
require 'spec_helper'

describe AjaxController do
  include FallSemester

  describe '#reservation_tabbox' do
    pending "Unsure what this will ultimately do right now"
  end

  describe '#check_equipment_availability' do
    before do
      setup_fall_semester_and_er_hours
      setup_test_categories

      @reservation_monday = FactoryGirl.create(:reservation,
        starts_at: Date.parse("Nov 26, 2012"), # Monday
        ends_at:   Date.parse("Nov 28, 2012") # Wednesday
      )

      @reservation_thursday = FactoryGirl.create(:reservation,
        starts_at: Date.parse("Nov 29, 2012"), # Thursday
        ends_at:   Date.parse("Dec 3, 2012") # Monday
      )

      @equipment = FactoryGirl.create(:equipment)
      FactoryGirl.create(:reserved_unit, reservation: @reservation_monday, unit: @equipment)
      FactoryGirl.create(:reserved_unit, reservation: @reservation_thursday, unit: @equipment)
    end

    context 'with a Tuesday to Thursday range' do
      before do
        @reservation_tuesday = FactoryGirl.create(:reservation,
          starts_at: Date.parse("Nov 27, 2012"), # Tuesday
          ends_at:   Date.parse("Nov 29, 2012") # Thursday
        )
        FactoryGirl.create(:reserved_unit, reservation: @reservation_thursday, unit: @equipment)

        xhr :get, :check_unit_availability,
          start_at:     @reservation_tuesday.starts_at,
          end_at:       @reservation_tuesday.ends_at,
          equipment:    [@equipment.id],
          accessories:  []

        @parsed_response = JSON.parse(response.body)
      end

      it 'is not available' do
        @parsed_response[@equipment.id]["available"].should be_false
      end
    end
  end

  describe '#equipment_dependencies' do
    pending "Hat"
  end
end
