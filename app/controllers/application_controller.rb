# frozen_string_literal: true

class ApplicationController < ActionController::Base
  rescue_from DogsClient::Error, ActionController::ParameterMissing, with: :render_error

  private

  def render_error(exception)
    respond_to do |format|
      format.turbo_stream do
        flash.now.alert = error_message(exception)
        render turbo_stream: turbo_stream.replace('error-message', partial: 'error_message')
      end

      format.html do
        flash.alert = error_message(exception)
        redirect_to root_path
      end
    end
  end

  def error_message(exception)
    case exception
    when DogsClient::NotFoundError then 'Breed not found. Try another one.'
    when DogsClient::TimeoutError then 'API request timed out. Please try again.'
    when ActionController::ParameterMissing then 'No breed is selected'
    else 'Something went wrong. Please try again.'
    end
  end
end
