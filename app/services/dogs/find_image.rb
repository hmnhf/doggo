# frozen_string_literal: true

module Dogs
  class FindImage
    class << self
      def call(breed_id:)
        breed, sub_breed = breed_id.split(':')
        DogsClient.breed_image(breed:, sub_breed:)
      end
    end
  end
end
