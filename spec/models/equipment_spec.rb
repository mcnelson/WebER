require 'spec_helper'

describe Equipment do
  it { is_expected.to belong_to(:equipment_category) }
  it { is_expected.to have_many(:accessory_dependencies) }
  it { is_expected.to have_many(:accessory_categories) }
end
