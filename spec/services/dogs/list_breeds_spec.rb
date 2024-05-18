require 'rails_helper'

RSpec.describe Dogs::ListBreeds do
  describe '.call' do
    subject { described_class.call }

    before { allow(DogsClient).to receive(:breeds).and_return(breeds) }

    let(:breeds) { { sheepdog: %w[english shetland], shiba: [] }.stringify_keys }

    it 'returns a map of breed names and their id' do
      expect(subject).to eq(
        {
          'Sheepdog' => 'sheepdog',
          'Sheepdog (English)' => 'sheepdog:english',
          'Sheepdog (Shetland)' => 'sheepdog:shetland',
          'Shiba' => 'shiba'
        }
      )
    end
  end
end
