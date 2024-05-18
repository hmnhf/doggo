# frozen_string_literal: true

module Dogs
  class ListBreeds
    ID_SEPARATOR = ':'

    class << self
      def call
        Rails.cache.fetch('dog_breeds', expires_in: 1.week) do
          DogsClient.breeds.each_with_object({}) do |(breed, sub_breeds), h|
            h[breed.titleize] = breed
            sub_breeds.each do |sub_breed|
              name = "#{breed.titleize} (#{sub_breed.titleize})"
              breed_id = "#{breed}#{ID_SEPARATOR}#{sub_breed}"
              h[name] = breed_id
            end
          end
        end
      end
    end
  end
end
