Rails.application.routes.draw do
  root to: 'medical_bills#index'
  get "/medical_bills/output", to: 'medical_bills#output'
  resources :medical_bills
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
