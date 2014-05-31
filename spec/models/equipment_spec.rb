require 'spec_helper'

describe Equipment do
  it { is_expected_to belong_to(:equipment_category) }
end
