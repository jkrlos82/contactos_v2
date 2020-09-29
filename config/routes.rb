Rails.application.routes.draw do
  get 'rows_validator/initialize'
  get 'rows_validator/validate'
  get 'rows_validator/errors'
  resources :csv_files
  resources :contacts
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "csv_files#index"
end
