# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :accessory_dependency do
    equipment_id 1
    accessory_equipment_id 1
    optional false
  end
end
