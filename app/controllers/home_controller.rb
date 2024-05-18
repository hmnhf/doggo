# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @breeds = Dogs::ListBreeds.call
  end
end
