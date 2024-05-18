require 'rails_helper'

RSpec.describe Dogs::FindImage do
  describe '.call' do
    subject { described_class.call(breed_id:) }

    let(:breed) { 'sheepdog' }
    let(:image_url) { 'https://images.dog.ceo/breeds/cattledog-australian/IMG_5177.jpg' }

    before do
      allow(DogsClient).to receive(:breed_image).with(
        breed:, sub_breed:
      ).and_return(image_url)
    end

    context 'when breed_id does not include a sub-breed' do
      let(:breed_id) { 'sheepdog' }
      let(:sub_breed) { nil }

      it 'returns an image' do
        expect(subject).to eq(image_url)
      end
    end

    context 'when breed_id includes a sub-breed' do
      let(:breed_id) { 'sheepdog:english' }
      let(:sub_breed) { 'english' }

      it 'returns an image' do
        expect(subject).to eq(image_url)
      end
    end
  end
end
