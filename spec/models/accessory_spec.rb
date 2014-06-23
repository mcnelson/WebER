require 'spec_helper'

describe Accessory do
  it { is_expected.to belong_to(:accessory_category) }

  describe '#name' do
    context 'has a category' do
      let(:category) { build_stubbed(:accessory_category, title: "Lanterns") }
      subject(:accessory) { Accessory.new(accessory_category: category) }

      it 'returns the singularized name of the category' do
        expect(accessory.name).to eql("Lantern")
      end
    end

    context 'has no category' do
      subject(:accessory) { Accessory.new(accessory_category: nil) }

      it 'returns nil' do
        expect(accessory.name).to be_nil
      end
    end
  end
end
