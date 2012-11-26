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
    category
    photo     fixture_file_upload('spec/images/hpx_test_photo.jpg')
    brand     "Panasonic"
    model     "HPX-4392"
    serial    "MB0932310111"
    # accessory - Up to the spec

    active    true
    notes     "Checked out with a little thing here and a little thing there"
  end

  factory :equipment_category do
    title "Cameras"
  end

  factory :equipment_package do
    # Write me
  end

  factory :er_hour do
    day         Date.parse("Monday")
    starts_at   Time.parse("1:00pm")
    ends_at     Time.parse("3:00pm")
  end

  factory :reservation do
    starts_at   Date.parse("Nov 12, 2012")
    ends_at     Date.parse("Nov 14, 2012")

    status
  end

  factory :user do
    punet                 "asdf1234"
    pu_student_id         "0900991"
    email                 "test@testerson.com"
    permission_level      "student"
    password              "asdf"
    password_confirmation "asdf"
  end

  factory :semester do
    starts_at   Date.parse("Oct 24, 2012")
    ends_at     Date.parse("Dec 14, 2012")
  end
end
