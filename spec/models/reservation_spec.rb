require 'spec_helper'

describe Reservation do
  describe 'validations' do
    describe '#lead_time' do
      let(:min_lead_time) { Weber::Application.config.reservation_min_lead_time }

      context "reservation starts any time during the day min_lead_time days from now" do
        let(:starts_at) { min_lead_time.from_now.change(hour: 9) }

        it 'is valid' do
          r = Reservation.new(starts_at: starts_at)
          r.lead_time
          expect(r.errors).to_not have_key(:starts_at)
        end
      end

      context "reservation starts any time during the current day" do
        let(:starts_at) { Time.now.change(hour: 3) }

        it 'is invalid' do
          r = Reservation.new(starts_at: starts_at)
          r.lead_time
          expect(r.errors).to have_key(:starts_at)
        end
      end
    end

    describe '#conflicting_reservations' do
      context 'empty reservation' do
        let(:reservation) { Reservation.new }

        it 'does not conflict' do
          reservation.conflicting_reservations
          expect(reservation.errors).to_not have_key(:base)
        end
      end

      context 'narrowly avoids conflicts with another reservation' do
        let(:unit) { create(:equipment) }

        let(:reservation) do
          build(:reservation).tap do |r|
            r.starts_at = Time.parse("June 3, 2014 3:00pm")
            r.ends_at   = Time.parse("June 5, 2014 3:00pm")

            r.reserved_equipment.build(unit: unit)
            r.user_id = 1
          end
        end

        before do
          build(:reservation).tap do |r|
            r.starts_at = Time.parse("June 1, 2014 3:00pm")
            r.ends_at   = Time.parse("June 3, 2014 3:00pm")

            r.equipment << unit
            r.user_id = 1
            r.save!(validate: false) # hehe
          end
        end

        it 'does not conflict' do
          reservation.conflicting_reservations
          expect(reservation.errors).to_not have_key(:base)
        end
      end

      context 'conflicts with another reservation' do
        let(:conflicted_unit) { create(:equipment) }
        let(:reservation) do
          build(:reservation).tap do |r|
            r.starts_at = Time.parse("June 3, 2014 3:00pm")
            r.ends_at   = Time.parse("June 5, 2014 3:00pm")

            r.equipment << conflicted_unit
            r.user_id = 1
          end
        end

        before do
          build(:reservation).tap do |r|
            r.starts_at = Time.parse("June 3, 2014 3:00pm")
            r.ends_at   = Time.parse("June 5, 2014 3:00pm")

            r.reserved_equipment.build(unit: conflicted_unit)
            r.user_id = 1
            r.save!(validate: false) # lulz
          end
        end

        it 'it conflicts' do
          reservation.conflicting_reservations
          expect(reservation.errors).to have_key(:base)
        end
      end
    end
  end

  describe '#duration' do
    let(:start_at) { Time.now }
    let(:end_at)   { 2.days.from_now }

    it 'returns the duration of the reservation' do
      r = Reservation.new(starts_at: start_at, ends_at: end_at)
      expect(r.duration.to_i).to be > 0
    end
  end
end
