Rails.application.routes.draw do
  resources :signups
  resources :activities
  resources :campers
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
