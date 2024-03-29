Rails.application.routes.draw do
  devise_for :users ,controllers: {
    registrations: 'users/registrations'
  }
  resources :lists do
      resources :items
  end

  root "home#index"

  
end
