# frozen_string_literal: true

class DogsController < ApplicationController
  def index
    breed_id = params.require(:breed_id)
    breed = breed_id.split(Dogs::ListBreeds::ID_SEPARATOR).first.titleize
    image_url = Dogs::FindImage.call(breed_id:)

    respond_to do |format|
      format.turbo_stream do
        image_stream = turbo_stream.replace('dog-preview', partial: 'dog', locals: { breed:, image_url: })
        error_stream = turbo_stream.replace('error-message', partial: 'error_message') # Clears the previous error if any
        render turbo_stream: [image_stream, error_stream]
      end

      format.html { redirect_to root_path }
    end
  end
end
