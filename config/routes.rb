Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'home#index'

  resources :medical_bills, except: :show

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/policy', to: 'home#policy'
  get '/disclaimer', to: 'home#disclaimer'

  resources :users do
    resources :family_members
    resources :payees
  end
end
