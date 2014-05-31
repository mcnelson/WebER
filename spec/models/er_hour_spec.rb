require 'spec_helper'

describe ErHour do
  describe 'assocations' do
    it { is_expected.to validate_presence_of(:wday) }
    it { is_expected.to validate_presence_of(:starts_at) }
    it { is_expected.to validate_presence_of(:ends_at) }
    it { is_expected.to validate_presence_of(:semester_id) }
  end

  describe 'validations' do
    it { is_expected.to belong_to(:checkin_hour) }
    it { is_expected.to belong_to(:semester) }

    describe '#once_per_weekday_per_semester' do
      it 'only allows one per weekday in a semester' do
        hour = build(:er_hour, wday: 5, semester_id: 1)
        expect(hour).to be_valid

        conflicting_hour = ErHour.new(wday: 5, semester_id: 1)
        expect(conflicting_hour).to be_invalid
      end
    end
  end

  describe '#wday_name' do
    it 'returns an abbreviated day name' do
      expect(ErHour.new(wday: 1).wday_name).to eql("Mon")
      expect(ErHour.new(wday: 5).wday_name).to eql("Fri")
    end
  end
end
