module FallSemester
  def setup_fall_semester_and_er_hours
    semester = FactoryGirl.create(:semester)

    FactoryGirl.create(:er_hour,
      day:        Date.parse("Monday"),
      starts_at:  Time.parse("1:00pm"),
      ends_at:    Time.parse("3:00pm"),
      semester:   semester
    )

    FactoryGirl.create(:er_hour,
      day:        Date.parse("Wednesday"),
      starts_at:  Time.parse("1:00pm"),
      ends_at:    Time.parse("3:00pm"),
      semester:   semester
    )

    FactoryGirl.create(:er_hour,
      day:        Date.parse("Tuesday"),
      starts_at:  Time.parse("11:30pm"),
      ends_at:    Time.parse("2:00pm"),
      semester:   semester
    )

    FactoryGirl.create(:er_hour,
      day:        Date.parse("Thursday"),
      starts_at:  Time.parse("11:00pm"),
      ends_at:    Time.parse("2:00pm"),
      semester:   semester
    )
  end

  def setup_test_categories
    FactoryGirl.create(:equipment_category, title: "Cameras")
    FactoryGirl.create(:equipment_category, title: "Tripods")
    FactoryGirl.create(:equipment_category, title: "Audio")
  end
end
