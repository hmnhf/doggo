require 'rails_helper'

RSpec.describe 'Dogs', type: :request do
  describe 'GET /dogs' do
    subject { get(dogs_path, params: { breed_id: }, as: :turbo_stream) }

    let(:breed_id) { 'sheepdog' }
    let(:image_url) { 'https://images.dog.ceo/breeds/cattledog-australian/IMG_5177.jpg' }

    before { allow(Dogs::FindImage).to receive(:call).with(breed_id:).and_return(image_url) }

    it 'responds with a turbo stream' do
      subject
      expect(response).to have_http_status(:ok)

      stream_body = response.stream.body
      expect(stream_body).to include('target="dog-preview"')
      expect(stream_body).to include("src=\"#{image_url}\"")
      expect(stream_body).to include('Sheepdog')
    end

    context 'when breed_id is not present' do
      let(:breed_id) { nil }

      it 'responds with an error' do
        subject
        expect(response).to have_http_status(:ok)

        stream_body = response.stream.body
        expect(stream_body).to include('target="error-message"')
        expect(stream_body).to include('No breed is selected')
      end
    end
  end
end
