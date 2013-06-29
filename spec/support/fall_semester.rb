module FallSemester
  def semester_with_test_er_hours(method = :create)
    FactoryGirl.public_send(method, :semester).tap do |semester|
      (1..5).each do |wday|
        semester.er_hours << FactoryGirl.public_send(method, :er_hour,
          wday:       wday,
          starts_at:  Time.parse("1:00pm"),
          ends_at:    Time.parse("3:00pm")
        )
      end
    end
  end

  def setup_test_categories
    FactoryGirl.create(:equipment_category, title: "Cameras")
    FactoryGirl.create(:equipment_category, title: "Tripods")
    FactoryGirl.create(:equipment_category, title: "Audio")
  end
end
