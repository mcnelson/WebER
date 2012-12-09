
require 'spec_helper'

describe AjaxController do
  include FallSemester

  before do
    setup_fall_semester_and_er_hours
    setup_test_categories
  end

  describe '#reservation_tabbox' do
    pending "Unsure what this will ultimately do right now"
  end

  describe '#check_equipment_availability' do
    before do

      # Make two existing reservations w/ 1 shared unit
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
        # Attempt reservation
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
        @unit_hash = @parsed_response[@equipment.id]
      end

      it 'contains a URL to the thumb photo' do
        @unit_hash["thumb"].should_not be_nil
        # TODO: URL match?
      end

      it 'is not available' do
        @unit_hash["available"].should be_false
      end
    end

    context 'with next week Monday to Wednesday' do
      before do
        # Attempt reservation
        @reservation_next_monday = FactoryGirl.create(:reservation,
          starts_at: Date.parse("Dec 3, 2012"), # Monday
          ends_at:   Date.parse("Dec 5, 2012") # Wednesday
        )
        FactoryGirl.create(:reserved_unit, reservation: @reservation_next_monday, unit: @equipment)

        xhr :get, :check_unit_availability,
          start_at:     @reservation_next_monday.starts_at,
          end_at:       @reservation_next_monday.ends_at,
          equipment:    [@equipment.id],
          accessories:  []

        @parsed_response = JSON.parse(response.body)
        @unit_hash = @parsed_response[@equipment.id]
      end

      it 'is available' do
        @unit_hash["available"].should be_true
      end
    end

    context 'with previous week Friday to Tuesday' do
      before do
        # Attempt reservation
        @reservation_prev_tuesday = FactoryGirl.create(:reservation,
          starts_at: Date.parse("Nov 23, 2012"), # Friday
          ends_at:   Date.parse("Nov 27, 2012") # Following Tuesday
        )
        FactoryGirl.create(:reserved_unit, reservation: @reservation_prev_tuesday, unit: @equipment)

        xhr :get, :check_unit_availability,
          start_at:     @reservation_prev_tuesday.starts_at,
          end_at:       @reservation_prev_tuesday.ends_at,
          equipment:    [@equipment.id],
          accessories:  []

        @parsed_response = JSON.parse(response.body)
        @unit_hash = @parsed_response[@equipment.id]
      end

      it 'is not available' do
        @unit_hash["available"].should be_false
      end

      #it 'suggests 
    end
  end

  describe '#equipment_dependencies' do
    pending "Hat"
  end
end
