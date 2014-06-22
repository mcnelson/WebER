FactoryGirl.define do
  factory :accessory_category do
    title "HPX Batteries"
  end

  factory :equipment do
    name      "HPX #1"
    brand     "Panasonic"
    model     "HPX-4392"
    serial    "MB0932310111"

    active    true
    notes     "Broken thingamabob"

    equipment_category
  end

  factory :accessory do
    brand "Panasonic"
    model "HBDS2224"
    serial "750871676"

    active    true
    notes "Holds about half charge"

    accessory_category
  end

  factory :equipment_category do
    title "Cameras"
  end

  factory :equipment_package do
    # Write me
  end

  factory :er_hour do
    wday        1
    starts_at   Time.parse("1:00pm")
    ends_at     Time.parse("3:00pm")
  end

  factory :reserved_unit

  factory :reservation do
    starts_at   1.day.from_now
    ends_at     3.days.from_now

    before :create do |r|
      r.user = FactoryGirl.create(:user)
    end

    factory :reservation_with_one_equipment do
      after :create do |r|
        e = FactoryGirl(:equipment)
        FactoryGirl.create(:equipment_reservation, reservation: r, equipment: e)
      end
    end

    factory :reservation_with_five_equipment do
      after :create do |r|
        5.times do
          e = FactoryGirl(:equipment)
          FactoryGirl.create(:equipment_reservation, reservation: r, equipment: e)
        end
      end
    end
  end

  sequence :punet do |n|
    "asdf%04d" % n
  end

  sequence :pu_student_id do |n|
    "%07d" % n
  end

  sequence :email do |n|
    "test#{n}@testerson.com"
  end

  factory :user do
    punet
    pu_student_id
    email

    permission_level      0
    password              "asdf"
    password_confirmation "asdf"
  end

  factory :semester do
    starts_at   Date.today.at_beginning_of_year
    ends_at     Date.today.at_end_of_year
  end
end
