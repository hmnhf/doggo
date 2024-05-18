class DogsClient
  class Error < StandardError; end
  class TimeoutError < Error; end
  class HTTPError < Error; end
  class NotFoundError < HTTPError; end

  TIMEOUT = 10.seconds.to_i

  class << self
    def breeds
      request('breeds/list/all')
    end

    def breed_image(breed:, sub_breed: nil)
      breed_type = [breed, sub_breed].compact.join('/')
      path = "breed/#{breed_type}/images/random"
      request(path)
    end

    private

    def request(path)
      url = "https://dog.ceo/api/#{path}"

      options = { timeout: { request_timeout: TIMEOUT } }
      response = HTTPX.with(options).get(url)
      validate_response(response:, url:)

      response.json.fetch('message')
    end

    def validate_response(response:, url:)
      return if response.try(:json)&.fetch('status') == 'success'

      Rails.logger.error("[#{name}] #{url} failed with: #{response.error}")

      raise_error(response)
    end

    def raise_error(response)
      case response
      in { status: 404 } then raise(NotFoundError, response.error)
      in { status: 400.. } then raise(HTTPError, response.error)
      in { error: }
        case error
        when HTTPX::RequestTimeoutError then raise(TimeoutError, error)
        else raise(Error, error)
        end
      else raise(Error, 'Unexpected error')
      end
    end
  end
end
