# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

Rails.application.routes.draw do
  get 'family_members/new'
  get 'family_members/edit'
  get 'family_members/show'
  get 'family_members/index'
  root to: 'home#index'

  resources :medical_bills do
    get 'output', on: :collection
  end

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :users
end
