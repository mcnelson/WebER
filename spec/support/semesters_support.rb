module SemestersSupport
  def semester_with_test_er_hours(method = :create)
    FactoryGirl.public_send(method, :semester).tap do |semester|
      (0...7).each do |wday|
        semester.er_hours.public_send(method, attributes_for(:er_hour).merge(wday: wday))
      end
    end
  end

  def setup_test_categories
    FactoryGirl.create(:equipment_category, title: "Cameras")
    FactoryGirl.create(:equipment_category, title: "Tripods")
    FactoryGirl.create(:equipment_category, title: "Audio")
  end
end
