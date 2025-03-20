Rails.application.routes.draw do
  # Devise
  devise_for :users

  # Rails health
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Home Page
  root 'home#index'

  # Profile
  get 'profile', to: 'profiles#show'
end
