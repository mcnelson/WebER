include ActionDispatch::TestProcess # For fixture_file_upload

FactoryGirl.define do
  factory :accessory_category do
    title "HPX Batteries"
  end

  # Not sure why this says a duplicate -- TODO fix me
 #factory :accessory_dependency do
 #  equipment
 #  accessory_category
 #end

  factory :equipment do
    name      "HPX #1"
    photo     { fixture_file_upload('spec/images/hpx_test_photo.jpg') }
    brand     "Panasonic"
    model     "HPX-4392"
    serial    "MB0932310111"
    accessory false

    active    true
    notes     "Checked out with a little thing here and a little thing there"

    before :create do |e|
      e.category = FactoryGirl.create(:equipment_category)
    end

    factory :accessory do
      accessory true

      name "HPX Battery #1"
      model "HBDS2224"
      notes ""

      before :create do |e|
        e.category = FactoryGirl.create(:accessory_category)
      end
    end
  end

  factory :equipment_category do
    title "Cameras"
  end

  factory :equipment_package do
    # Write me
  end

  factory :equipment_reservation do
  end

  factory :er_hour do
    day         Date.parse("Monday")
    starts_at   Time.parse("1:00pm")
    ends_at     Time.parse("3:00pm")
  end

  factory :reservation do
    starts_at   Date.parse("Nov 12, 2012")
    ends_at     Date.parse("Nov 14, 2012")

    before :create do |r|
      r.user = FactoryGirl.create(:user)
    end

    factory :reservation_with_one_equipment do
      after :create do |r|
        e = FactoryGirl(:equipment)
        FactoryGirl.create(:equipment_reservation, reservation: r, equipment: e)
      end
    end
  end

  factory :user do
    sequence :punet do |n|
      "asdf123#{n}"
    end

    sequence :pu_student_id do |n|
      "090099#{n}"
    end

    sequence :email do |n|
      "test#{n}@testerson.com"
    end

    permission_level      "student"
    password              "asdf"
    password_confirmation "asdf"
  end

  factory :semester do
    starts_at   Date.parse("Oct 24, 2012")
    ends_at     Date.parse("Dec 14, 2012")
  end
end
