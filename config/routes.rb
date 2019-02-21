# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

Rails.application.routes.draw do
  root to: 'medical_bills#index'
  resources :medical_bills do
    get 'output', on: :collection
  end

  get '/login', to: 'sessions#new'
  get '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
end
