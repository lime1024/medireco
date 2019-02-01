Rails.application.routes.draw do
  root to: 'medical_bills#index'
  resources :medical_bills do
    get 'output', on: :collection
    delete 'last_year_delete', on: :collection
    get 'last_year_output', on: :collection
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
