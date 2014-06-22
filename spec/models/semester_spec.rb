require 'spec_helper'

describe Semester do
  include SemestersSupport

  def date_on_wday(wday)
    Date.parse(Date::DAYS_INTO_WEEK.key(wday - 1).to_s) # Naughty
  end

  describe '#next_er_hour' do
    let!(:semester) { semester_with_test_er_hours(:build) }

    it 'returns a SpecificErHour' do
      semester.next_er_hour(date_on_wday(1)).should be_instance_of ErHour::SpecificErHour
    end

    it 'returns Friday given Friday' do
      semester.next_er_hour(date_on_wday(5)).date.wday.should eq(5)
    end

    it 'returns Monday given Saturday' do
      semester.next_er_hour(date_on_wday(6)).date.wday.should eq(1)
    end

    it 'returns Monday given Sunday' do
      semester.next_er_hour(date_on_wday(7)).date.wday.should eq(1)
    end

    it 'returns Wednesday given Wednesday' do
      semester.next_er_hour(date_on_wday(3)).date.wday.should eq(3)
    end
  end
end
