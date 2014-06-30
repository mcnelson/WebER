require 'spec_helper'

describe Category do
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to have_many(:units) }
end
