Rails.application.routes.draw do
  root 'home#index'

  resources :dogs, only: %i[index]
end
