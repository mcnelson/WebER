require 'spec_helper'

describe Semester do
  describe '#next_er_hour' do
    context 'on the weekend' do
      it 'returns a SpecificErHour on Monday' do
        @semester = FactoryGirl.create(:semester_with_er_hours, starts_at: Date.parse("Jan 1, 2013"), ends_at: Date.parse("Jan 20, 2013"))

        @semester.stub(:er_hour_on_day).
          with(Date.parse("Jan 13, 2013")) { nil } # Sunday

        @semester.stub(:er_hour_on_day).
          with(Date.parse("Jan 14, 2013")) { FactoryGirl.build(:er_hour, day: Date.parse("Monday")) }

        specific_er_hour = @semester.next_er_hour(Date.parse("Jan 13, 2013"))

        specific_er_hour.should_not be_nil
        specific_er_hour.should be_instance_of ErHour::SpecificErHour
        specific_er_hour.date.should == Date.parse("Jan 14, 2013")
      end
    end
  end
end
