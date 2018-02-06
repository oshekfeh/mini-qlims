Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :sample_types, :except => [:destroy]
  resources :test_types, :except => [:destroy]
  resources :units, :except => [:destroy]
end
