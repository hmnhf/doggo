require 'rails_helper'

RSpec.describe DogsClient do
  describe '.breeds' do
    subject { described_class.breeds }

    it 'returns a map of breeds and their sub-breeds' do
      VCR.use_cassette('list_breeds') do
        expect(subject).to be_a(Hash)
        expect(subject.count).to eq(98)
        expect(subject.fetch('african')).to match_array([])
        expect(subject.fetch('sheepdog')).to match_array(%w[english shetland])
      end
    end
  end

  describe '.breed_image' do
    subject { described_class.breed_image(breed:, sub_breed:) }

    let(:breed) { 'sheepdog' }
    let(:sub_breed) { nil }

    it 'returns an image URL of the breed' do
      VCR.use_cassette('breed_image') do
        expect(subject).to eq('https://images.dog.ceo/breeds/sheepdog-shetland/n02105855_18141.jpg')
      end
    end

    context 'when sub-breed is present' do
      let(:sub_breed) { 'english' }

      it 'returns an image URL of the sub-breed' do
        VCR.use_cassette('sub_breed_image') do
          expect(subject).to eq('https://images.dog.ceo/breeds/sheepdog-english/n02105641_9502.jpg')
        end
      end
    end

    context 'when a breed does not exist' do
      let(:sub_breed) { 'wrong' }

      it 'raises NotFoundErrorError' do
        VCR.use_cassette('sub_breed_image_404') do
          expect { subject }.to raise_error(described_class::NotFoundError)
        end
      end
    end
  end
end
